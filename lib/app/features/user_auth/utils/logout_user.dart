import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/google_auth/google_auth.dart';

Future<void> logout(BuildContext context) async {
  await GoogleAuthService().signOut();

  Navigator.pushReplacementNamed(context, '/login');
}
