import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';
import 'package:todo_riverpod/app/features/todo/data/repositories/repositories.dart';
import 'package:todo_riverpod/app/utils/functions/analytics_utils.dart';
import 'package:todo_riverpod/app/utils/task_notification_helper.dart';

class TodoNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  final Repositories api;
  final String userId;

  TodoNotifier(this.api, this.userId) : super(const AsyncValue.loading()) {
    fetchTodos();
  }

  Future<void> addTodo(TodoModel todo) async {
    state = const AsyncValue.loading();
    try {
      await api.addTodo(userId, todo);

      await logTaskCreated(taskName: todo.title);

      // Schedule notifications for the task (exact time, 10 min, 30 min before)
      await TaskNotificationHelper.scheduleTaskNotifications(todo);

      await fetchTodos();
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchTodos() async {
    state = const AsyncValue.loading();
    try {
      final todos = await api.getTodos(userId);
      state = AsyncValue.data(todos);
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
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
      await api.updateTodoStatus(
        userId,
        updatedTodo.id,
        updatedTodo.isCompleted,
      );

      // Handle notifications based on completion status
      if (updatedTodo.isCompleted) {
        // Task completed - show celebration and cancel pending notifications
        await TaskNotificationHelper.showTaskCompletedNotification(updatedTodo);
      } else {
        // Task uncompleted - reschedule notifications
        await TaskNotificationHelper.scheduleTaskNotifications(updatedTodo);
      }
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      if (mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTodo(String id) async {
    state = const AsyncValue.loading();

    try {
      await api.deleteTodo(userId, id);

      await logTaskDeleted(taskId: id);

      // Cancel all pending notifications for this task
      await TaskNotificationHelper.cancelTaskNotifications(id);

      await fetchTodos();
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st);
      state = AsyncValue.error(e, st);
    }
  }
}
