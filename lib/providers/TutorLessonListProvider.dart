import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/service/LessonService.dart';

class TutorLessonListProvider extends ChangeNotifier {
  final List<Lesson> lessonList;
  TutorLessonListProvider({required this.lessonList});
  final _lessonService = const LessonService();

  Future<void> bookLesson(Lesson lesson, User user) async {
    await _lessonService.bookLesson(lesson, user);
    notifyListeners();
  }
}
