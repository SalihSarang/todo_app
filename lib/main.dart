import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:todo_riverpod/app/features/todo/presentation/screens/home_screen.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/login_screen/login_screen.dart';
import 'package:todo_riverpod/app/utils/functions/handle_initial_message.dart';
import 'package:todo_riverpod/app/utils/functions/init_firebase.dart';
import 'package:todo_riverpod/firebase_options.dart';

RemoteMessage? initialMessage;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initFirebaseNotification();
  initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialMessage != null) {
        handleInitialMessage(context, initialMessage);
        initialMessage = null;
      }
    });

    final observer = FirebaseAnalyticsObserver(analytics: analytics);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [observer],
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
