import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/auth_service.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user_auth/business/auth_loading_provider.dart';

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
  required WidgetRef ref,
  required void Function(String? message) onError,
}) async {
  if (!formKey.currentState!.validate()) return;

  ref.read(authLoadingProvider.notifier).state = true;

  try {
    final credental = await _authService.signUp(
      email: email,
      password: password,
    );

    debugPrint('User created: ${credental.user?.uid}');

    final user = UserModel(uid: credental.user!.uid, name: name, email: email);

    await _userColection.addUser(user);

    onError(null);
    if (context.mounted) {
      await Navigator.pushReplacementNamed(context, '/home');
    }
  } on FirebaseAuthException catch (e) {
    debugPrint('Signup failed: ${e.message}');
    FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
    onError(_mapSignupError(e));
  } catch (e, s) {
    debugPrint('Signup failed: $e');
    FirebaseCrashlytics.instance.recordError(e, s);
    onError('Signup failed. Please try again.');
  } finally {
    ref.read(authLoadingProvider.notifier).state = false;
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
