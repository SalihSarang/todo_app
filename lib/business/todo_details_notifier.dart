import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/data/model/todo_model.dart';
import 'package:todo_riverpod/data/repositories/repositories.dart';

class TodoDetailsNotifier extends StateNotifier<AsyncValue<TodoModel>> {
  final Repositories api;

  TodoDetailsNotifier(this.api) : super(const AsyncValue.loading());

  Future<void> fetchDetails(String id) async {
    state = const AsyncValue.loading();
    try {
      final details = await api.getTodoDetails(id);
      state = AsyncValue.data(details);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
