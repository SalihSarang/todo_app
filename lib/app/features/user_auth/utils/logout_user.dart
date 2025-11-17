import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  Navigator.pushReplacementNamed(context, '/login');
}
