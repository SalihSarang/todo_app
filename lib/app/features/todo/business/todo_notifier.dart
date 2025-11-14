import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';
import 'package:todo_riverpod/app/features/todo/data/repositories/repositories.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  final Repositories api;
  TodoNotifier(this.api) : super(const AsyncValue.loading()) {
    fetchTodos();
  }

  Future<void> addTodo(TodoModel todo) async {
    state = const AsyncValue.loading();
    try {
      await api.addTodo(todo);
      await fetchTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchTodos() async {
    state = const AsyncValue.loading();
    try {
      final todos = await api.getTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void toggleCompleted(String id) async {
    final currentTodos = state.value ?? [];

    final updatedTodos = [
      for (final todo in currentTodos)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];

    state = AsyncValue.data(updatedTodos);
    try {
      final updatedTodo = updatedTodos.firstWhere((todo) => todo.id == id);
      await api.updateTodoStatus(updatedTodo.id, updatedTodo.isCompleted);
    } catch (e, st) {
      if (mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTodo(String id) async {
    state = const AsyncValue.loading();

    try {
      await api.deleteTodo(id);
      await fetchTodos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
