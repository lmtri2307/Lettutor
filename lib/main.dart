import 'package:flutter/material.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/routing/RouteGenerator.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

void main() {
  usePathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(create: (context) => TutorListProvider(),)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String _currentRoute = "/";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepository = context.watch<AuthProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authRepository.isLoggedIn) {
        if (_currentRoute == "/login" ||
            _currentRoute == "/" ||
            _currentRoute == "/signup") {
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil("/home", (route) => false);
        }
        return;
      }

      if (_currentRoute != "/login" &&
          _currentRoute != "/signup" &&
          _currentRoute != "/password") {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil("/login", (route) => false);
      }
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        final route = authRepository.isLoggedIn
            ? settings.name == "/login" ||
                    settings.name == "/signup" ||
                    settings.name == "/password"
                ? RouteGenerator.onGenerateRoute(
                    RouteSettings(name: "/home", arguments: settings.arguments))
                : RouteGenerator.onGenerateRoute(settings)
            : settings.name != "/login" &&
                    settings.name != "/signup" &&
                    settings.name != "/password"
                ? RouteGenerator.onGenerateRoute(RouteSettings(
                    name: "/login", arguments: settings.arguments))
                : RouteGenerator.onGenerateRoute(settings);
        _currentRoute = route.settings.name!;
        return route;
      },
      initialRoute: _currentRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 113, 240),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 113, 240)),
        textTheme: TextTheme(
            headlineLarge: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
            headlineSmall: const TextStyle(
              fontSize: 20,
            ),
            bodyMedium: const TextStyle(
              fontSize: 16,
            ),
            bodySmall: const TextStyle(fontSize: 14)),
        useMaterial3: true,
      ),
    );
  }
}
