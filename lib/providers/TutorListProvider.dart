import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Tutor.dart';

class TutorListProvider extends ChangeNotifier {
  List<Tutor> tutorList = [];

  void setTutorList(List<Tutor> tutorList) {
    this.tutorList = tutorList;
    notifyListeners();
  }

  void toggleFavoriteTutor(Tutor tutor) {
    var tutorInList = tutorList.firstWhere(
      (element) => element.id == tutor.id,
    );
    print(tutorInList.isFavorite ? false : true);
    tutorInList.isFavorite = tutorInList.isFavorite ? false : true;
    print(tutorInList.isFavorite);
    // print(tutorList.elementAt(0).isFavorite);
    notifyListeners();
    // print(index);
    // if(index != -1){
    //   final newTutor = tutorList[index].copyWith(isFavorite: !tutorList[index].isFavorite);
    //   tutorList[index] = newTutor;
    //   notifyListeners();
    // }
  }
}
