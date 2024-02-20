import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/LessonService.dart';

class TutorLessonListProvider extends ChangeNotifier {
  final _lessonService = const LessonService();
  final Tutor tutor;

  List<Lesson> lessonList = [];
  bool isEndOfList = false;
  bool isFetching = false;
  TutorLessonListProvider(this.tutor);
  int page = 0;

  Future<void> fetchTutorLessonList() async {

    if(isEndOfList) return;
    isFetching = true;
    notifyListeners();

    // fetch data
    final fetchedLessonList = await _lessonService.getLessonListOfTutor(tutor, page);
    lessonList.addAll(fetchedLessonList);
    if(fetchedLessonList.isEmpty){
      isEndOfList = true;
    }

    page++;
    isFetching = false;
    notifyListeners();
  }

  void updateLesson(Lesson oldLesson, Lesson newLesson){
    final index = lessonList.indexOf(oldLesson);
    if(index != -1){
      lessonList[index] = newLesson;
      notifyListeners();
    }
  }
}
