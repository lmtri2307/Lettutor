import 'package:lettutor/dummy/specialty.dart';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';

class TutorService {
  const TutorService();

  Future<List<Specialty>> getAllSpecialty() async {
    await Future.delayed(const Duration(seconds: 2));
    return specialtyList;
  }

  Future<List<Tutor>> getTutorList() async {
    await Future.delayed(const Duration(seconds: 2));
    final copyList = [...tutorList];
    copyList.sort(
      (a, b) {
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
      },
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => copyList,
    );
  }

  Future<List<Tutor>> searchByFilter(Specialty specialty) async {
    await Future.delayed(const Duration(seconds: 2));
    if (specialty == Specialty.all) {
      return tutorList;
    }

    return tutorList
        .where((tutor) => tutor.specialtyList
            .any((tutorSpecialty) => tutorSpecialty.name == specialty.name))
        .toList();
  }

  Future<Tutor> toggleFavoriteTutor(Tutor tutor) async {
    return tutor.copyWith(isFavorite: !tutor.isFavorite);
  }

  Future<TutorDetail?> getTutorDetail(Tutor tutor) async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () => tutor.detail,
    );
  }
}
