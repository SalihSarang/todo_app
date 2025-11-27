import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/splash_screen/business/splash_screen_provider.dart';
import 'package:todo_riverpod/app/utils/functions/firebase_analytics/log_events.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _handleNavigation(BuildContext context, WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 2));

    final authState = ref.read(authStateProvider);
    final userFromStream = authState.value;
    final user = userFromStream ?? FirebaseAuth.instance.currentUser;

    if (!context.mounted) return;

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Log analytics on first build
    logScreen('SplashScreen');
    logEvent(
      name: 'splash_screen_viewed',
      parameters: {'screen': 'SplashScreen'},
    );

    // Trigger navigation after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleNavigation(context, ref);
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'TODO APP',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
