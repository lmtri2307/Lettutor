import 'package:flutter/material.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/providers/LessonProvider.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/routing/RouteGenerator.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  final authProvider = AuthProvider();
  try {
    final user = await const AuthService().refreshSession();
    authProvider.setUser(user);
  } catch (e) {
    // ignore error
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => authProvider,
      ),
      ChangeNotifierProvider(
        create: (context) => TutorListProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LessonProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.watch<AuthProvider>();
    final routeGenerator = RouteGenerator(
      checkLoggedIn: () => authRepository.isLoggedIn,
    );

    const primaryColor = Color.fromARGB(255, 0, 113, 240);
    return MaterialApp(
      navigatorKey: RouteGenerator.navigatorKey,
      onGenerateRoute: routeGenerator.onGenerateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
            headlineSmall: TextStyle(
              fontSize: 20,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
            ),
            bodySmall: TextStyle(fontSize: 14)),
        useMaterial3: true,
      ),
    );
  }
}
