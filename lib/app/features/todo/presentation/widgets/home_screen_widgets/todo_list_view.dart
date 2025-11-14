import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/business/todo_provider.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/home_screen_widgets/empty_list.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/home_screen_widgets/error_view.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/home_screen_widgets/todo_card.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/common/loading.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);

    return todos.when(
      data: (todos) {
        if (todos.isEmpty) return EmptyList();

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoCard(todo: todo);
          },
        );
      },
      error: (error, stackTrace) => ErrorView(error: error),
      loading: () => const LoadingState(),
    );
  }
}
