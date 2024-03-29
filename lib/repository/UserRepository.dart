import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';

class UserRepository {
  const UserRepository();

  final baseUrl = '/user';

  Future<Duration> getTotalLessonTime() async {
    final response = await apiClient.get(Uri.parse("/call/total"));
    final data = json.decode(response.body);

    return Duration(minutes: data['total']);
  }

  Future<List<BookedLesson>> getNextLessonList() async {
    final response = await apiClient.get(Uri.parse("/booking/next"));
    final data = json.decode(response.body);
    final List<BookedLesson> lessonList = data['data']
        .map<BookedLesson>((lesson) => BookedLesson(
              studentMeetingLink: lesson['studentMeetingLink'],
              id: lesson['id'],
              startTime: DateTime.fromMillisecondsSinceEpoch(
                  lesson['scheduleDetailInfo']['startPeriodTimestamp']),
              duration: DateTime.fromMillisecondsSinceEpoch(
                      lesson['scheduleDetailInfo']['startPeriodTimestamp'])
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                      lesson['scheduleDetailInfo']['endPeriodTimestamp']))
                  .abs(),
              tutor: Tutor(
                id: lesson['scheduleDetailInfo']['scheduleInfo']['tutorInfo']
                    ['id'],
                name: lesson['scheduleDetailInfo']['scheduleInfo']['tutorInfo']
                    ['name'],
                specialtyList: [],
                avatar: lesson['scheduleDetailInfo']['scheduleInfo']
                    ['tutorInfo']['avatar'],
                country: lesson['scheduleDetailInfo']['scheduleInfo']
                    ['tutorInfo']['country'],
              ),
            ))
        .toList();
    final nextLessonList = lessonList
        .where((element) => element.startTime.isAfter(DateTime.now()))
        .toList();
    return nextLessonList;
  }

  Future<(List<BookedLesson>, int)> _getBookedLessonList(int page, int perPage,
      {bool upcoming = true}) async {
    final url =
        '/booking/list/student?page=$page&perPage=$perPage&inFuture=${upcoming ? '1' : '0'}&orderBy=meeting&sortBy=${upcoming ? 'asc' : 'desc'}';
    final response = await apiClient.get(Uri.parse(url));
    final data = json.decode(response.body);

    final int count = data['data']['count'];
    final List<BookedLesson> lessonList = data['data']['rows']
        .map<BookedLesson>((lesson) => BookedLesson(
              studentMeetingLink: lesson['studentMeetingLink'],
              id: lesson['id'],
              tutor: Tutor(
                id: lesson['scheduleDetailInfo']['scheduleInfo']['tutorInfo']
                    ['id'],
                name: lesson['scheduleDetailInfo']['scheduleInfo']['tutorInfo']
                    ['name'],
                specialtyList: [],
                avatar: lesson['scheduleDetailInfo']['scheduleInfo']
                    ['tutorInfo']['avatar'],
                country: lesson['scheduleDetailInfo']['scheduleInfo']
                    ['tutorInfo']['country'],
              ),
              startTime: DateTime.fromMillisecondsSinceEpoch(
                  lesson['scheduleDetailInfo']['startPeriodTimestamp']),
              duration: DateTime.fromMillisecondsSinceEpoch(
                      lesson['scheduleDetailInfo']['startPeriodTimestamp'])
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                      lesson['scheduleDetailInfo']['endPeriodTimestamp']))
                  .abs(),
            ))
        .toList();
    return (lessonList, count);
  }

  Future<(List<BookedLesson>, int)> getScheduleLessonList(
      int page, int perPage) async {
    return await _getBookedLessonList(page, perPage, upcoming: true);
  }

  Future<(List<Lesson>, int)> getHistoryLessonList(
      int page, int perPage) async {
    return await _getBookedLessonList(page, perPage, upcoming: false);
  }
}
