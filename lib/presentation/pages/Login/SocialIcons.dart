import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.facebookF, color: Color(0xFF1877F2)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.google, color: Color(0xFFDB4437)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.mobileAlt, color: Colors.black),
          ),
        ),
      ],
    );
  }
}