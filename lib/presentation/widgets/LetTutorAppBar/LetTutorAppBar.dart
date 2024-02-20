import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/enums/language.dart';
import 'package:lettutor/presentation/widgets/LetTutorAppBar/LanguageOption.dart';
import 'package:lettutor/providers/LocaleProvider.dart';
import 'package:provider/provider.dart';

class LetTutorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const   LetTutorAppBar(
      {super.key, this.isLoggedIn = false, this.hasBackButton = false});

  final bool isLoggedIn;
  final bool hasBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

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
        automaticallyImplyLeading: hasBackButton,
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
                  localeProvider.locale == const Locale('vi') ? 'assets/images/vietnam.svg' : 'assets/images/english.svg',
                  semanticsLabel: 'Your SVG Image',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
                onSelected: (Language result) {
                  if(result == Language.vietnam) {
                    localeProvider.setLocale(const Locale('vi'));
                  } else {
                    localeProvider.setLocale(const Locale('en'));
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Language>>[
                  const PopupMenuItem<Language>(
                    value: Language.vietnam,
                    child: LanguageOption(language: Language.vietnam),
                  ),
                  const PopupMenuItem<Language>(
                    value: Language.en,
                    child: LanguageOption(language: Language.en),
                  ),
                ],
                offset: const Offset(0, 40),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          if (isLoggedIn)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(225, 228, 230, 235),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: IconButton(
                    icon: Icon(Icons.list),
                    iconSize: 16,
                    onPressed: null,
                  )),
            ),
        ],
      ),
    );
  }
}
