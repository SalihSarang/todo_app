import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/auth_service.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/user_repository.dart';

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
}) async {
  if (formKey.currentState!.validate()) {
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

      await Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      debugPrint('Signup failed: ${e.message}');
    }
  }
}
