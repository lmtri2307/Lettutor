import 'package:flutter/material.dart';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CoursesPage.dart';
import 'package:lettutor/presentation/pages/HistoryPage/HistoryPage.dart';
import 'package:lettutor/presentation/pages/Home/HomePage.dart';
import 'package:lettutor/presentation/pages/Login/LoginPage.dart';
import 'package:lettutor/presentation/pages/Schedule/SchedulePage.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 113, 240),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 113, 240)),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor
          ),
          headlineSmall: const TextStyle(
            fontSize: 20,
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
          ),
          bodySmall: const TextStyle(
            fontSize: 14
          )
        ),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: CoursesPage(),
        // child: HistoryPage(),
        // child: SchedulePage(),
        // child: TutorPage(tutor: tutorList[0],),
        // child: LoginPage(),
        // child: Home(),
      )

    );
  }
}

