import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Topic.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/CourseDetailPage/CourseDetailPage.dart';
import 'package:lettutor/presentation/pages/Login/LoginPage.dart';
import 'package:lettutor/presentation/pages/NavigationPage/NavigationPage.dart';
import 'package:lettutor/presentation/pages/SignUpPage/SignUpPage.dart';
import 'package:lettutor/presentation/pages/SplashPage/SplashPage.dart';
import 'package:lettutor/presentation/pages/TopicPage/TopicPage.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorPage.dart';
import 'package:lettutor/presentation/pages/VideoCallPage/VideoCallPage.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    try {
      final page = switch (settings.name) {
        "/" => const SplashPage(),
        "/home" => const NavigationPage(),
        "/login" => const LoginPage(),
        "/signup" => const SignUpPage(),
        "/tutor" => TutorPage(tutor: settings.arguments! as Tutor),
        "/course" => CourseDetailPage(
            course: settings.arguments! as Course,
          ),
        "/topic" => TopicPage(
            topic: settings.arguments! as Topic,
          ),
        "/call" => const VideoCallPage(),
        _ => const Center(
            child: Text("404"),
          )
      };
      return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return SafeArea(
              child: page,
              // child: AuthNavigating(
              //   child: page,
              // ),
            );
          });
    } catch (e) {
      print("catch");
      return onGenerateRoute(
          RouteSettings(name: "/login", arguments: settings.arguments));
    }
  }
}
