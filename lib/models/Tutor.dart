import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/enums/tutor_filter_choice.dart';

class Tutor {
  Tutor(
      {required this.name,
      this.avatarUrl,
      this.country = "Unknown country",
      this.rating,
      this.labels = const [],
      this.introduction = ""});

  final String name;
  final String country;
  final String? avatarUrl;
  double? rating;
  final List<TutorFilterChoice> labels;
  final String introduction;

  Widget get avatar => avatarUrl != null
      ? CircleAvatar(
          radius: 45,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(avatarUrl!),
              ),
            ),
          ),
        )
      : CircleAvatar(
          radius: 45,
          child: FittedBox(child: Avatar(name: name)),
        );
}
