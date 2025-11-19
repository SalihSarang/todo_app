import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/splash_screen/business/splash_screen_provider.dart';
import 'package:todo_riverpod/app/features/todo/business/todo_notifier.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';
import 'package:todo_riverpod/app/features/todo/data/repositories/repositories.dart';

final userIdProvider = Provider<String>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) throw Exception("User not logged in");
      return user.uid;
    },
    loading: () => "",
    error: (e, _) => "",
  );
});

final apiServiceProvider = Provider<Repositories>((ref) => Repositories());

final todoStateProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<List<TodoModel>>>((ref) {
      final api = ref.read(apiServiceProvider);
      final userId = ref.watch(userIdProvider);
      return TodoNotifier(api, userId);
    });

final todoDetailsProvider = FutureProvider.family<TodoModel, String>((
  ref,
  id,
) async {
  final api = ref.read(apiServiceProvider);
  final userId = ref.watch(userIdProvider);
  return api.getTodoDetails(userId, id);
});

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

final selectedTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
