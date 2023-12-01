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
  @override
  Widget build(BuildContext context) {
    final authRepository = context.watch<AuthProvider>();
    final routeGenerator = RouteGenerator(checkLoggedIn: () => authRepository.isLoggedIn,);
    return MaterialApp(
      navigatorKey: RouteGenerator.navigatorKey,
      onGenerateRoute: routeGenerator.onGenerateRoute,
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
