import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_notifier.dart';
import 'package:todo_riverpod/app/features/user_auth/business/user_providre.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, AsyncValue<UserModel>>((
      ref,
    ) {
      final repo = ref.watch(userRepositoryProvider);
      final uid = ref.watch(userIdProvider);
      return ProfileNotifier(repo, uid);
    });

final pickedImageProvider = StateProvider<File?>((ref) => null);
