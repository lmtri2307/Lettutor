import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Language {
  vietnam("vietnam"),
  us("united-states");

  final String name;

  const Language(this.name);

  Widget get imageWidget => SvgPicture.asset(
    'assets/images/$name.svg',
    semanticsLabel: 'Your SVG Image',
    width: 24,
    height: 24,
    fit: BoxFit.cover,
  );
}