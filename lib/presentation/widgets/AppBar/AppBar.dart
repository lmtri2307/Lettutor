import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/enums/language.dart';
import 'package:lettutor/presentation/widgets/AppBar/LanguageOption.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.isLogined = false});

  final bool isLogined;

  @override
  Size get preferredSize => const Size.fromHeight(70);

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
        toolbarHeight: double.infinity,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/images/logo.svg',
          semanticsLabel: 'Your SVG Image',
          fit: BoxFit.fitHeight,
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
                  'assets/images/vietnam.svg',
                  semanticsLabel: 'Your SVG Image',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
                onSelected: (Language result) {
                  // Handle your menu selection here
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Language>>[
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
          const SizedBox(width: 8,),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(225, 228, 230, 235),
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(Icons.list), // replace 'favorite' with the icon you want
                iconSize: 16, // adjust the size as needed
                color: Colors.red, // adjust the color as needed
                onPressed: null,
              )
            ),
          ),
        ],
      ),
    );
  }
}
