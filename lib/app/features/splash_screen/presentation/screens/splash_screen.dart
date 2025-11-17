import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/splash_screen/business/splash_screen_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    // show splash min 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // 1. Try to read current auth state from stream (Riverpod)
    final authState = ref.read(authStateProvider);

    // 2. If the authStateProvider has a value, use it
    final userFromStream = authState.value;

    // 3. If stream didn’t emit yet, fall back to currentUser
    final user = userFromStream ?? FirebaseAuth.instance.currentUser;

    // Navigate safely
    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
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
