import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_riverpod/main.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await MyApp.analytics.logLogin(loginMethod: 'Email_and_Password');
    log('Firebase Event: logLogin sent for method: Email_and_Password.');

    return userCredential;
  }
}
