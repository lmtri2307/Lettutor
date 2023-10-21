import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/enums/language.dart';
import 'package:lettutor/presentation/Login/LanguageOption.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'images/logo.svg',
          semanticsLabel: 'Your SVG Image',
          fit: BoxFit.contain,
          width: 180,
        ),
        actions: [
          // PopupMenuButton(itemBuilder: itemBuilder)
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(225, 228, 230, 235),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PopupMenuButton<Language>(
                icon: SvgPicture.asset(
                  'images/vietnam.svg',
                  semanticsLabel: 'Your SVG Image',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
                onSelected: (Language result) {
                  // Handle your menu selection here
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
                  const PopupMenuItem<Language>(
                    value: Language.vietnam,
                    child: LanguageOption(language: Language.vietnam),
                  ),
                  const PopupMenuItem<Language>(
                    value: Language.us,
                    child: LanguageOption(language: Language.us),
                  ),
                ],
                offset: const Offset(0, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
