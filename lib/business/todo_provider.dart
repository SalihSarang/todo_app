import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_notifier.dart';
import 'package:todo_riverpod/data/model/todo_model.dart';
import 'package:todo_riverpod/data/repositories/repositories.dart';

final apiServiceProvider = Provider<Repositories>((ref) => Repositories());

final todosProvider = FutureProvider<List<TodoModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.getTodos();
});

final todoStateProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<List<TodoModel>>>((ref) {
      ref.keepAlive();
      return TodoNotifier(ref.read(apiServiceProvider));
    });

final todoDetailsProvider = FutureProvider.family<TodoModel, String>((
  ref,
  id,
) async {
  final api = ref.read(apiServiceProvider);
  return api.getTodoDetails(id);
});

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

final selectedTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
