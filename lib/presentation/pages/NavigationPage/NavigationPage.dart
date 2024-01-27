import "package:flutter/material.dart";
import "package:lettutor/presentation/pages/CoursesPage/CoursesPage.dart";
import "package:lettutor/presentation/pages/HistoryPage/HistoryPage.dart";
import "package:lettutor/presentation/pages/Home/HomePage.dart";
import "package:lettutor/presentation/pages/SchedulePage/SchedulePage.dart";
import "package:lettutor/presentation/pages/SettingPage/SettingPage.dart";
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _pageList = [
    const Home(),
    const SchedulePage(),
    const HistoryPage(),
    const CoursesPage(),
    const SettingPage(),
  ];
  int _chosenPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_chosenPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _chosenPageIndex = value;
          });
        },
        elevation: 20,
        currentIndex: _chosenPageIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_filled), label: AppLocalizations.of(context).home),
          BottomNavigationBarItem(icon: const Icon(Icons.schedule_outlined), label: AppLocalizations.of(context).schedule),
          BottomNavigationBarItem(icon: const Icon(Icons.history_edu), label: AppLocalizations.of(context).history),
          BottomNavigationBarItem(icon: const Icon(Icons.school), label: AppLocalizations.of(context).course),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: AppLocalizations.of(context).settings),
        ],
      ),
    );
  }
}

