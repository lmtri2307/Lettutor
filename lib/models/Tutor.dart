import 'package:lettutor/models/Nationality.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/TutorDetail.dart';

class Tutor{
  Tutor({
    required this.id,
    required this.specialties,
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
  String? specialties;
  String? avatar;
  String name;
  String? country;
  String? bio;
  double? rating;
  int? numOfReviews;
  bool isFavorite;
  TutorDetail? detail;
  Nationality? nationality;
  List<Specialty> get specialtyList =>
      specialties?.split(",").map((e) => Specialty(e)).toList() ?? [];

  Tutor copyWith({
    String? id,
    String? specialties,
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
        specialties: specialties ?? this.specialties,
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
