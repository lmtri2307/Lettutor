import "package:flutter/material.dart";
import "package:lettutor/presentation/pages/CoursesPage/CoursesPage.dart";
import "package:lettutor/presentation/pages/HistoryPage/HistoryPage.dart";
import "package:lettutor/presentation/pages/Home/HomePage.dart";
import "package:lettutor/presentation/pages/SchedulePage/SchedulePage.dart";


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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

