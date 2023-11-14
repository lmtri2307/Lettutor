import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Topic.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/CourseDetailPage/CourseDetailPage.dart';
import 'package:lettutor/presentation/pages/Login/LoginPage.dart';
import 'package:lettutor/presentation/pages/NavigationPage/NavigationPage.dart';
import 'package:lettutor/presentation/pages/TopicPage/TopicPage.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorPage.dart';
import 'package:lettutor/presentation/pages/VideoCallPage/VideoCallPage.dart';

class RouteGenerator {
  static bool idLoggedIn = false;
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    final calculatedSettings = RouteSettings(
        name: idLoggedIn ? settings.name : "/login",
        arguments: settings.arguments);

    try {
      final page = switch (calculatedSettings.name) {
        "/" => const NavigationPage(),
        "/login" => const LoginPage(),
        "/tutor" =>
            TutorPage(tutor: calculatedSettings.arguments! as Tutor),
        "/course" =>
            CourseDetailPage(
              course: calculatedSettings.arguments! as Course,
            ),
        "/topic" =>
            TopicPage(
              topic: calculatedSettings.arguments! as Topic,
            ),
        "/call" => const VideoCallPage(),
        _ =>
        const Center(
          child: Text("404"),
        )
      };
      return MaterialPageRoute(
          settings: calculatedSettings,
          builder: (context) {
            return SafeArea(
              child: page,
            );
          });
    } catch (e) {
      return onGenerateRoute(
          RouteSettings(name: "/", arguments: settings.arguments));
    }
  }
}
