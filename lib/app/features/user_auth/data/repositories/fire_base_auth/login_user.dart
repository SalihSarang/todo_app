import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/auth_service.dart';

final _authService = AuthService();

Future<void> loginUser({
  required GlobalKey<FormState> formKey,
  required String email,
  required String password,
  required BuildContext context,
  required void Function(String? message) onError,
}) async {
  if (!formKey.currentState!.validate()) return;

  try {
    final credential = await _authService.login(
      email: email,
      password: password,
    );

    debugPrint('Login Successful: ${credential.user?.uid}');
    onError(null);
    Navigator.pushReplacementNamed(context, '/home');
  } on FirebaseAuthException catch (e) {
    debugPrint('Login failed: ${e.message}');
    onError(_mapLoginError(e));
  } catch (e) {
    debugPrint('Login failed: $e');
    onError('Login failed. Please try again.');
  }
}

String _mapLoginError(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'No account found for that email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'invalid-credential':
      return 'Invalid credentials. Please try again.';
    case 'user-disabled':
      return 'This account has been disabled. Contact support.';
    default:
      return e.message ?? 'Login failed. Please try again.';
  }
}
