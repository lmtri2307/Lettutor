import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/repository/LessonRepository.dart';
import 'package:lettutor/repository/UserRepository.dart';

class LessonService {
  const LessonService();

  final _lessonRepository = const LessonRepository();
  final _userRepository = const UserRepository();

  Future<List<Lesson>> getNextLessonList() async {
    final lessonList = await _userRepository.getNextLessonList();
    lessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return lessonList;
  }

  Future<Lesson?> getUpcomingLesson() async {
    final lessonList = await getNextLessonList();
    if (lessonList.isEmpty) {
      return null;
    }
    return lessonList.first;
  }

  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor, int page) async {
    final lessonList =
        await _lessonRepository.getLessonListOfTutor(tutor, page);
    lessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return lessonList;
  }

  Future<Lesson> bookLesson(Lesson lesson, String note) async {
    await _lessonRepository.bookLesson(lesson, note);

    final resultLesson = lesson.copyWith(isAvailable: false);
    bookedLessonList.add(resultLesson);
    return resultLesson;
  }

  Future<Duration> getTotalLessonTime() async {
    return await _userRepository.getTotalLessonTime();
  }

  Future<(List<Lesson>, int)> getScheduleLessonList(
      int page, int perPage) async {
    final (lessonList, count) =
        await _userRepository.getScheduleLessonList(page, perPage);
    return (
      const DateHelper().sortByDate(lessonList, (item) => item.startTime),
      count
    );
  }

  Future<(List<Lesson>, int)> getHistoryLessonList(
      int page, int perPage) async {
    final (historyLessonList, count) =
        await _userRepository.getHistoryLessonList(page, perPage);
    return (
      const DateHelper().sortByDate(historyLessonList, (item) => item.startTime,
          ascending: false),
      count
    );
  }
}
