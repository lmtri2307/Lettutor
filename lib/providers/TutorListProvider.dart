import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Tutor.dart';

class TutorListProvider extends ChangeNotifier {
  List<Tutor> tutorList = [];
  bool isFetching = false;

  void setTutorList(List<Tutor> tutorList) {
    this.tutorList = tutorList;
    notifyListeners();
  }

  void setTutorListFuture(Future<List<Tutor>> tutorListFuture) async {
    isFetching = true;
    notifyListeners();
    final tutorList = await tutorListFuture;
    this.tutorList = tutorList;
    isFetching = false;
    notifyListeners();
  }

  void setIsFetching(bool isFetching) {
    this.isFetching = isFetching;
    notifyListeners();
  }

  void toggleFavoriteTutor(Tutor tutor) {
    var tutorInList = tutorList.firstWhere(
      (element) => element.id == tutor.id,
    );
    tutorInList.isFavorite = tutorInList.isFavorite ? false : true;
    notifyListeners();
  }
}
