import 'package:lettutor/models/Nationality.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/TutorDetail.dart';

class Tutor {
  Tutor({
    required this.id,
    required this.specialtyList,
    this.avatar,
    required this.name,
    this.country,
    this.bio,
    this.rating,
    this.numOfReviews,
    this.detail,
    this.nationality,
    this.isFavorite = false,
  });

  String id;
  String? avatar;
  String name;
  String? country;
  String? bio;
  double? rating;
  int? numOfReviews;
  bool isFavorite;
  TutorDetail? detail;
  Nationality? nationality;
  List<Specialty> specialtyList;

  Tutor copyWith({
    String? id,
    List<Specialty>? specialtyList,
    String? avatar,
    String? name,
    String? country,
    String? bio,
    double? rating,
    int? numOfReviews,
    bool? isFavorite,
    TutorDetail? detail,
  }) {
    return Tutor(
        id: id ?? this.id,
        specialtyList: specialtyList ?? this.specialtyList,
        name: name ?? this.name,
        country: country ?? this.country,
        bio: bio ?? this.bio,
        isFavorite: isFavorite ?? this.isFavorite,
        avatar: avatar ?? this.avatar,
        numOfReviews: numOfReviews ?? this.numOfReviews,
        rating: rating ?? this.rating,
        detail: detail ?? this.detail);
  }
}
