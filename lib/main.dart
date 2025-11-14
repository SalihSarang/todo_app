import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/presentation/screens/home_screen.dart';
import 'package:todo_riverpod/app/features/user/presentation/screen/user_profile_screen/user_profile_screen.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/login_screen/login_screen.dart';
import 'package:todo_riverpod/firebase_options.dart';

final mockUser = User(
  uid: 'user-auth-token-1234567890abcdef',
  displayName: 'Todo App User',
  email: 'user@todoapp.com',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}
