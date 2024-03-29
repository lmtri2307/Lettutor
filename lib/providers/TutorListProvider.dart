import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorListProvider extends ChangeNotifier {
  List<Tutor> tutorList = [];
  bool isFetching = false;
  bool isEndOfList = false;
  int page = 1;
  final limit = 10;
  final _tutorService = const TutorService();
  TutorSearchFormData? searchForm;
  Future<List<Tutor>>? _runningFuture;

  void resetPage() {
    page = 1;
    isEndOfList = false;
  }

  Future<void> toggleFavoriteTutor(Tutor tutor) async {
    await _tutorService.toggleFavoriteTutor(tutor);
    notifyListeners();
  }

  List<Tutor> _sortTutorList(List<Tutor> tutorList) {
    final copyList = [...tutorList];
    copyList.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) {
        return -1;
      } else if (!a.isFavorite && b.isFavorite) {
        return 1;
      } else if (a.rating == null || b.rating == null) {
        return a.rating == null && b.rating == null
            ? 0
            : a.rating == null
                ? 1
                : -1;
      } else {
        return b.rating!.compareTo(a.rating!);
      }
    });
    return copyList;
  }

  Future<void> fetchTutorList() async {
    if (isEndOfList) return;
    isFetching = true;
    // if current page is 1, clear the list
    if (page == 1) {
      tutorList = [];
      notifyListeners();
    }

    // fetch data
    late Future<List<Tutor>> fetchedTutorListFuture;
    if (searchForm == null) {
      fetchedTutorListFuture =
          _tutorService.search(TutorSearchFormData(), page, limit);
    } else {
      fetchedTutorListFuture = _tutorService.search(searchForm!, page, limit);
    }
    _runningFuture = fetchedTutorListFuture;
    final fetchedTutorList = await fetchedTutorListFuture;

    // if the future is not the latest one, ignore it
    if (_runningFuture != fetchedTutorListFuture) return;
    if (fetchedTutorList.length < limit) {
      isEndOfList = true;
    }

    tutorList.addAll(_sortTutorList(fetchedTutorList));
    page++;
    isFetching = false;
    notifyListeners();
  }

  Future<void> searchTutorList(TutorSearchFormData formData) async {
    searchForm = formData;
    resetPage();
    fetchTutorList();
  }
}
