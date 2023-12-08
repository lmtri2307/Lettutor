import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/User.dart';

class LessonService {
  const LessonService();
  Future<Lesson?> getUpcomingLesson(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    if(bookedLessonList.isEmpty){
      return null;
    } else {
      bookedLessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
      return bookedLessonList.firstWhere((element) => element.startTime.isAfter(DateTime.now()));
    }
  }

  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor) async {
    await Future.delayed(const Duration(seconds: 2));
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
}