import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Language{
  vietnam("vietnam"),
  us("united-states");

  final String name;
  const Language(this.name);
  Widget get imageWidget => SvgPicture.asset(
    'images/$name.svg',
    semanticsLabel: 'Your SVG Image',
    width: 24,
    height: 24,
    fit: BoxFit.cover,
  );
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Placeholder(),
            Placeholder()
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  const LanguageOption({super.key, required this.language});
  final Language language;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        language.imageWidget,
        const SizedBox(width: 8),
        Expanded(child: Text(language.name)),
      ],
    );
  }
}

