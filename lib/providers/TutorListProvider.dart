import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorListProvider extends ChangeNotifier {
  List<Tutor> tutorList = [];
  bool isFetching = false;
  Future<List<Tutor>>? _tutorListFuture;
  final _tutorService = const TutorService();

  void setTutorList(List<Tutor> tutorList) {
    this.tutorList = tutorList;
    notifyListeners();
  }

  void setTutorListFuture(Future<List<Tutor>> tutorListFuture) async {
    isFetching = true;
    notifyListeners();
    _tutorListFuture = tutorListFuture;
    final tutorList = await tutorListFuture;
    if(_tutorListFuture == tutorListFuture){
      this.tutorList = tutorList;
      isFetching = false;
      notifyListeners();
    }
  }

  void setIsFetching(bool isFetching) {
    this.isFetching = isFetching;
    notifyListeners();
  }

  Future<void> toggleFavoriteTutor(Tutor tutor) async {
    await _tutorService.toggleFavoriteTutor(tutor);
    notifyListeners();
  }
}
