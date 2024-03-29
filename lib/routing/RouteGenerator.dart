import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Topic.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/BecomeTutorPage.dart';
import 'package:lettutor/presentation/pages/CourseDetailPage/CourseDetailPage.dart';
import 'package:lettutor/presentation/pages/EditProfilePage/EditProfilePage.dart';
import 'package:lettutor/presentation/pages/ForgotPasswordPage/ForgotPasswordPage.dart';
import 'package:lettutor/presentation/pages/Login/LoginPage.dart';
import 'package:lettutor/presentation/pages/NavigationPage/NavigationPage.dart';
import 'package:lettutor/presentation/pages/SignUpPage/SignUpPage.dart';
import 'package:lettutor/presentation/pages/SplashPage/SplashPage.dart';
import 'package:lettutor/presentation/pages/TopicPage/TopicPage.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorPage.dart';
import 'package:lettutor/presentation/pages/TutorSchedulePage/TutorSchedulePage.dart';
import 'package:lettutor/presentation/pages/VideoCallPage/VideoCallPage.dart';

class RouteGenerator {
  RouteGenerator({required this.checkLoggedIn}) {
    if (!isLoggedIn && protectedRoutes.contains(_currentRoute)) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(publicRoutes[0], (route) => false);
    }

    if (isLoggedIn && publicRoutes.contains(_currentRoute)) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(protectedRoutes[0], (route) => false);
    }
  }

  final bool Function() checkLoggedIn;
  static String? _currentRoute;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  bool get isLoggedIn => checkLoggedIn();
  final publicRoutes = const ["/login", "/password", "/signup"];
  final protectedRoutes = const [
    "/home",
    "/tutor",
    "/course",
    "/topic",
    "/call",
    "/become-tutor",
    "/tutor-schedule",
    "/edit-profile"
  ];

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    _currentRoute = settings.name;
    if (!isLoggedIn && !publicRoutes.contains(settings.name)) {
      return onGenerateRoute(
          RouteSettings(name: publicRoutes[0], arguments: settings.arguments));
    }

    if (isLoggedIn && !protectedRoutes.contains(settings.name)) {
      return onGenerateRoute(RouteSettings(
          name: protectedRoutes[0], arguments: settings.arguments));
    }
    try {
      final page = switch (settings.name) {
        "/" => const SplashPage(),
        "/home" => const NavigationPage(),
        "/login" => const LoginPage(),
        "/password" => const ForgotPasswordPage(),
        "/signup" => const SignUpPage(),
        "/tutor" => TutorPage(tutor: settings.arguments! as Tutor),
        // "/tutor" => TutorPage(tutor: tutorList[0]),
        "/course" => CourseDetailPage(
            course: settings.arguments! as Course,
          ),
        "/topic" => TopicPage(
            topic: settings.arguments! as Topic,
          ),
        "/call" => VideoCallPage(lesson: settings.arguments! as BookedLesson),
        "/become-tutor" => const BecomeTutorPage(),
        "/tutor-schedule" => TutorSchedulePage(
            tutor: settings.arguments! as Tutor,
          ),
        // "/tutor-schedule" => TutorSchedulePage(tutor: tutorList[0],),
        "/edit-profile" => const EditProfilePage(),
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
