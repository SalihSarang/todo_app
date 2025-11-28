import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/user_repository.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserModel>> {
  final UserRepository repo;
  final String? uid;

  ProfileNotifier(this.repo, this.uid) : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    if (uid == null || uid!.isEmpty) {
      state = const AsyncLoading();
      return;
    }

    try {
      final user = await repo.getUser(uid!);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateName(String name) async {
    final current = state.value;
    if (current == null) return;

    if (uid == null || uid!.isEmpty) return;

    final updated = current.copyWith(name: name);
    state = AsyncValue.data(updated);

    await repo.updateUser(updated);
  }

  Future<void> updateImageURL(String url) async {
    if (uid == null || uid!.isEmpty) return;

    await repo.updateProfileImage(uid!, url);

    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(imgURL: url);
    state = AsyncValue.data(updated);
  }

  Future<void> updateAddress(String address) async {
    final current = state.value;
    if (current == null) return;

    if (uid == null || uid!.isEmpty) return;

    final updated = current.copyWith(address: address);
    state = AsyncValue.data(updated);

    await repo.updateUser(updated);
  }
}
