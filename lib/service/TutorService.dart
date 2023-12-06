import 'dart:math';

import 'package:lettutor/dummy/review.dart';
import 'package:lettutor/dummy/specialty.dart';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/dummy/nationality.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';
import 'package:lettutor/models/Nationality.dart';
import 'package:lettutor/models/TutorSearchFormData.dart';

class TutorService {
  const TutorService();

  Future<List<Specialty>> getAllSpecialty() async {
    await Future.delayed(const Duration(seconds: 2));
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

  Future<List<Tutor>> getTutorList() async {
    await Future.delayed(const Duration(seconds: 2));
    return _sortTutorList(tutorList);
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
    return await Future.delayed(
      const Duration(seconds: 3),
      () => tutor.detail,
    );
  }

  Future<List<Tutor>> searchTutorByName(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    return tutorList.where((tutor) => tutor.name.contains(name)).toList();
  }

  Future<List<Nationality>> getAllNationality() async {
    await Future.delayed(const Duration(seconds: 2));
    return nationalityList;
  }

  Future<List<Tutor>> search(TutorSearchFormData formData) async {
    await Future.delayed(const Duration(seconds: 2));
    var result = tutorList;
    if (formData.name != null) {
      result = result
          .where((tutor) =>
              tutor.name.toLowerCase().contains(formData.name!.toLowerCase()))
          .toList();
    }
    if (formData.specialty != null && formData.specialty != Specialty.all) {
      result = result
          .where((tutor) => tutor.specialtyList
              .any((specialty) => specialty.name == formData.specialty!.name))
          .toList();
    }
    if (formData.tutorNationality != null) {
      result = result
          .where((tutor) => tutor.nationality == formData.tutorNationality)
          .toList();
    }

    return _sortTutorList(result);
  }

  Future<void> report(Tutor tutor, String reportContent) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<List<Review>> getReviewList(Tutor tutor) async {
    await Future.delayed(const Duration(seconds: 2));
    final copy = List<Review>.from(reviewList);
    int length = tutor.numOfReviews ?? 0;

    return copy
      ..shuffle(Random())
      ..length = length;
  }
}
