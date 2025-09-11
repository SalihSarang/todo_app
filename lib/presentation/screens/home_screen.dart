import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/presentation/widgets/todo_cart.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: todos.when(
        data: (todos) {
          if (todos.isEmpty) return Center(child: Text('No Todo Added yet!'));

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoCard(todo: todo);
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
