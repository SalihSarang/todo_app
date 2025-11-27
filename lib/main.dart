import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:todo_riverpod/app/features/todo/presentation/screens/home_screen.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/login_screen/login_screen.dart';
import 'package:todo_riverpod/app/utils/functions/handle_initial_message.dart';
import 'package:todo_riverpod/app/utils/functions/init_firebase.dart';
import 'package:todo_riverpod/app/utils/notification_service.dart';
import 'package:todo_riverpod/firebase_options.dart';

RemoteMessage? initialMessage;
Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await initFirebaseNotification();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      initialMessage = await FirebaseMessaging.instance.getInitialMessage();

      await FirebaseAnalytics.instance.logAppOpen();

      // Initialize local notifications
      await NotificationService().initialize();

      // Test notification
      Future.delayed(const Duration(seconds: 5), () {
        NotificationService().showNotification(
          id: 999,
          title: 'Test Notification',
          body: 'If you see this, notifications are working!',
        );
      });

      runApp(ProviderScope(child: MyApp()));
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialMessage != null) {
        handleInitialMessage(context, initialMessage);
        initialMessage = null;
      }
    });

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
