import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/user_repository.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userIdProvider = Provider<String>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception("User not logged in");
  return user.uid;
});

final userProvider = FutureProvider<UserModel>((ref) async {
  final repo = ref.read(userRepositoryProvider);
  final uid = ref.read(userIdProvider);
  return repo.getUser(uid);
});
