import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';

class TutorService {
  const TutorService();

  Future<List<Tutor>> getTutorList() async {
    return tutorList.map((e) {
      e.numOfReviews = null;
      return e;
    }).toList();
  }

  Future<Tutor> toggleFavoriteTutor(Tutor tutor) async {
    return tutor.copyWith(isFavorite: !tutor.isFavorite);
  }

  Future<TutorDetail?> getTutorDetail(Tutor tutor) async {
    return await Future.delayed(const Duration(seconds: 3), () => tutor.detail,);
  }
}
