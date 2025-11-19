import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/business/todo_provider.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';
import 'package:todo_riverpod/app/features/user_auth/utils/logout_user.dart';

Future<void> deleteAccount(BuildContext context, WidgetRef ref) async {
  final userRepo = UserRepository();

  final uid = ref.read(userIdProvider);

  await userRepo.deleteUser(uid);

  await FirebaseAuth.instance.currentUser!.delete();
  await logout(context);
}
