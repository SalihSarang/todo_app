import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/auth_service.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';

final _authService = AuthService();
final _userColection = UserRepository();
void registerUser({
  required GlobalKey<FormState> formKey,
  required String name,
  required String email,
  required String password,
  required String comfirmPassword,
  required String phone,
  required BuildContext context,
  required void Function(String? message) onError,
}) async {
  if (!formKey.currentState!.validate()) return;

  try {
    final credental = await _authService.signUp(
      email: email,
      password: password,
    );

    debugPrint('User created: ${credental.user?.uid}');

    final user = UserModel(
      uid: credental.user!.uid,
      name: name,
      email: email,
      password: password,
    );

    await _userColection.addUser(user);

    onError(null);
    await Navigator.pushReplacementNamed(context, '/home');
  } on FirebaseAuthException catch (e) {
    debugPrint('Signup failed: ${e.message}');
    onError(_mapSignupError(e));
  } catch (e) {
    debugPrint('Signup failed: $e');
    onError('Signup failed. Please try again.');
  }
}

String _mapSignupError(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'An account already exists for that email.';
    case 'weak-password':
      return 'Please choose a stronger password.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'operation-not-allowed':
      return 'Email/password sign up is disabled for this project.';
    default:
      return e.message ?? 'Signup failed. Please try again.';
  }
}
