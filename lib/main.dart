import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/providers/LessonProvider.dart';
import 'package:lettutor/providers/LocaleProvider.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/routing/RouteGenerator.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages("vi", timeago.ViMessages());

  usePathUrlStrategy();
  final authProvider = AuthProvider();
  try {
    final user = await const AuthService().refreshSession();
    authProvider.setUser(user);
  } catch (e) {
    // ignore error
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "734010348446390",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
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
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
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
      locale: context.watch<LocaleProvider>().locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
