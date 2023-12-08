import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Lesson.dart';
class TutorLessonListProvider extends ChangeNotifier {
  final List<Lesson> lessonList;
  TutorLessonListProvider({required this.lessonList});

  void updateLesson(Lesson oldLesson, Lesson newLesson){
    final index = lessonList.indexOf(oldLesson);
    if(index != -1){
      lessonList[index] = newLesson;
      notifyListeners();
    }
  }
}
