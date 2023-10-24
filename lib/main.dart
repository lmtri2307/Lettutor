import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/Home/Home.dart';

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
      home: const SafeArea(
        child: Home(),
      )

    );
  }
}

