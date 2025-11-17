import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/user_repository.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserModel>> {
  final UserRepository repo;
  final String uid;

  ProfileNotifier(this.repo, this.uid) : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final user = await repo.getUser(uid);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateName(String name) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(name: name);
    state = AsyncValue.data(updated);

    await repo.updateUser(updated);
  }

  Future<void> updateImageURL(String url) async {
    await repo.updateProfileImage(uid, url);

    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(imgURL: url);
    state = AsyncValue.data(updated);
  }
}
