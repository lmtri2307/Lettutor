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

  Future<List<Lesson>> getNextLessonList() async {
    final response = await apiClient.get(Uri.parse("/booking/next"));
    final data = json.decode(response.body);
    final List<Lesson> lessonList = data['data']
        .map<Lesson>((lesson) => Lesson(
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

  Future<(List<Lesson>, int)> getScheduleLessonList(
      int page, int perPage) async {
    final url =
        '/booking/list/student?page=$page&perPage=$perPage&inFuture=1&orderBy=meeting&sortBy=asc';
    final response = await apiClient.get(Uri.parse(url));
    final data = json.decode(response.body);

    final int count = data['data']['count'];
    final List<Lesson> lessonList = data['data']['rows']
        .map<Lesson>((lesson) => Lesson(
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
}
