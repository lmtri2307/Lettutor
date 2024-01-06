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

  void setTutorListFuture(Future<List<Tutor>> tutorListFuture,
      {bool appendList = false}) async {
    isFetching = true;
    notifyListeners();
    _tutorListFuture = tutorListFuture;
    final tutorList = await tutorListFuture;
    if (_tutorListFuture == tutorListFuture) {
      if (appendList) {
        this.tutorList.addAll(tutorList);
      } else {
        this.tutorList = tutorList;
      }
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

  Future<void> fetchTutorList(int page, int limit) async {
    isFetching = true;
    notifyListeners();
    final tutorList = await _tutorService.getTutorList(page, limit);
    if (page == 1) {
      this.tutorList = tutorList;
    } else {
      this.tutorList.addAll(tutorList);
    }
    isFetching = false;
    notifyListeners();
  }

  Future<void> searchTutorList(TutorSearchFormData formData) async {
    final tutorList = await _tutorService.search(formData);
    setTutorList(tutorList);
  }
}
