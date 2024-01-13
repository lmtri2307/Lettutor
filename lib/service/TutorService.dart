import 'dart:math';

import 'package:lettutor/dummy/review.dart';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/dummy/nationality.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';
import 'package:lettutor/models/Nationality.dart';
import 'package:lettutor/repository/TutorRepository.dart';

class TutorSearchFormData {
  String? name;
  Nationality? tutorNationality;
  Specialty? specialty;

  TutorSearchFormData({this.name, this.tutorNationality, this.specialty});
}

class TutorService {
  final tutorRepository = const TutorRepository();
  const TutorService();

  Future<List<Specialty>> getAllSpecialty() async {
    return specialtyList;
  }

  List<Tutor> _sortTutorList(List<Tutor> tutorList) {
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
    return copyList;
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

  Future<void> toggleFavoriteTutor(Tutor tutor) async {
    tutor.isFavorite = !tutor.isFavorite;
  }

  Future<TutorDetail?> getTutorDetail(Tutor tutor) async {
    final tutorDetail = await tutorRepository.getTutorDetail(tutor);
    return tutorDetail;
  }

  Future<List<Tutor>> searchTutorByName(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    return tutorList.where((tutor) => tutor.name.contains(name)).toList();
  }

  Future<List<Nationality>> getAllNationality() async {
    await Future.delayed(const Duration(seconds: 2));
    return nationalityList;
  }

  Future<List<Tutor>> search(TutorSearchFormData formData, int page, int limit) async {
    final tutorList = await tutorRepository.searchTutorList(formData, page, limit);
    return tutorList;
  }

  Future<void> report(Tutor tutor, String reportContent) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<List<Review>> getReviewList(Tutor tutor) async {
    await Future.delayed(const Duration(seconds: 2));
    final copy = List<Review>.from(reviewList);
    int length = tutor.detail?.numOfReviews ?? 0;

    return copy
      ..shuffle(Random())
      ..length = length;
  }
}
