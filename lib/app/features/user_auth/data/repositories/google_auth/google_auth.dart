import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';
import 'package:todo_riverpod/main.dart';

class GoogleAuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _userRepository = UserRepository();

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await _saveUserIfNeeded(user);

        // Log analytics event for Google Sign-In
        await MyApp.analytics.logLogin(loginMethod: 'Google');
        log('Firebase Event: logLogin sent for method: Google.');
      }

      return user;
    } catch (error, stackTrace) {
      debugPrint('Google sign-in failed: $error');
      debugPrint('$stackTrace');

      // Record error in Crashlytics
      FirebaseCrashlytics.instance.recordError(error, stackTrace);

      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    try {
      await _googleSignIn.disconnect();
    } catch (_) {}
    await _auth.signOut();
  }

  Future<void> _saveUserIfNeeded(User user) async {
    final exists = await _userRepository.userExists(user.uid);
    if (exists) return;

    final userModel = UserModel(
      uid: user.uid,
      name: (user.displayName != null && user.displayName!.trim().isNotEmpty)
          ? user.displayName!.trim()
          : 'Google User',
      email: user.email ?? '',
      imgURL: user.photoURL,
    );

    await _userRepository.addUser(userModel);
  }
}
