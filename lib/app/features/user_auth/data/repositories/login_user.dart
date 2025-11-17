import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/auth_service.dart';

final _authService = AuthService();

Future<void> loginUser({
  required GlobalKey<FormState> formKey,
  required String email,
  required String password,
  required BuildContext context,
}) async {
  if (formKey.currentState!.validate()) {
    try {
      final credential = await _authService.login(
        email: email,
        password: password,
      );

      debugPrint('Login Successful: ${credential.user?.uid}');
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      debugPrint('Login failed: ${e.message}');
    }
  }
}
