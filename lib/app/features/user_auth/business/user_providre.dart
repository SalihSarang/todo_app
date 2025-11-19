import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/splash_screen/business/splash_screen_provider.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user?.uid,
    loading: () => null,
    error: (_, __) => null,
  );
});

final userProvider = FutureProvider<UserModel?>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  final uid = ref.watch(userIdProvider);
  if (uid == null) return null;
  return repo.getUser(uid);
});
