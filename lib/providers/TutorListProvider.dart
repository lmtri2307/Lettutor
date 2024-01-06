import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorListProvider extends ChangeNotifier {
  List<Tutor> tutorList = [];
  bool isFetching = false;
  Future<List<Tutor>>? _tutorListFuture;
  int page = 1;
  final limit = 10;
  final _tutorService = const TutorService();

  void setTutorList(List<Tutor> tutorList) {
    this.tutorList = tutorList;
    notifyListeners();
  }

  void resetPage() {
    page = 1;
  }

  void setIsFetching(bool isFetching) {
    this.isFetching = isFetching;
    notifyListeners();
  }

  Future<void> toggleFavoriteTutor(Tutor tutor) async {
    await _tutorService.toggleFavoriteTutor(tutor);
    notifyListeners();
  }

  Future<void> fetchTutorList() async {
    isFetching = true;
    final fetchedTutorList = await _tutorService.getTutorList(page, limit);
    if (page == 1) {
      tutorList = fetchedTutorList;
    } else {
      tutorList.addAll(fetchedTutorList);
    }
    page++;
    isFetching = false;
    notifyListeners();
  }

  Future<void> searchTutorList(TutorSearchFormData formData) async {
    final tutorList = await _tutorService.search(formData);
    setTutorList(tutorList);
  }
}
