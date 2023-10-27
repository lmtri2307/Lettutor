import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/Language.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Specialty.dart';

class Tutor {
  Tutor(
      {required this.name,
      this.avatarUrl,
      this.country = "Unknown country",
      this.rating,
      this.reviewList,
      this.videoUrl,
      this.languageList,
      this.specialtyList,
      this.interest,
      this.experience,
      this.introduction = ""});

  final String name;
  final String country;
  final String? avatarUrl;
  double? rating;

  // final List<TutorFilterChoice> labels;
  final String introduction;
  final List<Review>? reviewList;
  final String? videoUrl;
  List<Language>? languageList;
  List<Specialty>? specialtyList;
  String? interest;
  String? experience;

  Widget get avatar => FittedBox(
      child: SizedBox.square(
          child: CircleAvatar(
              child: avatarUrl != null
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(avatarUrl!),
                        ),
                      ),
                    )
                  : FittedBox(child: Avatar(name: name)))));
}
