import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/User.dart';

class LessonService {
  const LessonService();
  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor) async {
    await Future.delayed(const Duration(seconds: 2));
    return lessonList;
  }

  Future<void> bookLesson(Lesson lesson, User user) async {
    await Future.delayed(const Duration(seconds: 2));
    lesson.isAvailable = false;
  }
}