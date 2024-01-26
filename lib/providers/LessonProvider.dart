import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/providers/TutorLessonListProvider.dart';
import 'package:lettutor/service/LessonService.dart';

class LessonProvider extends ChangeNotifier{
  BookedLesson? upcomingLesson;
  bool needFetchUpcomingLesson = true;
  TutorLessonListProvider? tutorLessonListProvider;
  final LessonService _lessonService = const LessonService();
  LessonProvider();

  Future<void> fetchUpcomingLesson() async {
    upcomingLesson = await _lessonService.getUpcomingLesson();
    needFetchUpcomingLesson = false;
    notifyListeners();
  }

  Future<void> bookLesson(Lesson lesson, String note) async {
    final newLesson = await _lessonService.bookLesson(lesson, note);
    tutorLessonListProvider?.updateLesson(lesson, newLesson);
    fetchUpcomingLesson();
  }
}