import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/repository/LessonRepository.dart';

class LessonService {
  const LessonService();
  final _lessonRepository = const LessonRepository();

  Future<Lesson?> getUpcomingLesson(User user) async {
    final scheduleLessonList = await getScheduleLessonList(user);
    if (scheduleLessonList.isEmpty) {
      return null;
    } else {
      return scheduleLessonList[0];
    }
  }

  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor, int page) async {
    final lessonList = await _lessonRepository.getLessonListOfTutor(tutor, page);
    lessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return lessonList;
  }

  Future<Lesson> bookLesson(Lesson lesson, User user) async {
    await Future.delayed(const Duration(seconds: 2));
    final resultLesson = lesson.copyWith(isAvailable: false);
    bookedLessonList.add(resultLesson);
    return resultLesson;
  }

  Future<Duration> getTotalLessonTime(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return const Duration(hours: 6, minutes: 29);
  }

  Future<List<Lesson>> getScheduleLessonList(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    final scheduleLessonList = bookedLessonList
        .where((element) => element.startTime.isAfter(DateTime.now()))
        .toList();
    return const DateHelper()
        .sortByDate(scheduleLessonList, (item) => item.startTime);
  }

  Future<List<Lesson>> getHistoryLessonList(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    final historyLessonList = bookedLessonList
        .where((element) => element.startTime.isBefore(DateTime.now()))
        .toList();
    return const DateHelper().sortByDate(
        historyLessonList, (item) => item.startTime,
        ascending: false);
  }
}
