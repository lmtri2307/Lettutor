import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/providers/TutorLessonListProvider.dart';
import 'package:lettutor/service/LessonService.dart';

class LessonProvider extends ChangeNotifier{
  Lesson? upcomingLesson;
  bool needFetchUpcomingLesson = true;
  TutorLessonListProvider? tutorLessonListProvider;
  final LessonService _lessonService = const LessonService();
  LessonProvider();

  Future<void> fetchUpcomingLesson(User user) async {
    upcomingLesson = await _lessonService.getUpcomingLesson(user);
    needFetchUpcomingLesson = false;
    notifyListeners();
  }
  Future<void> bookLesson(Lesson lesson, User user) async {
    final newLesson = await _lessonService.bookLesson(lesson, user);
    tutorLessonListProvider?.updateLesson(lesson, newLesson);
    fetchUpcomingLesson(user);
  }
}