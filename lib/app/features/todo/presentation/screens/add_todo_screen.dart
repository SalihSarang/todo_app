import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/add_todo_widgets/todo_add_form.dart';
import 'package:todo_riverpod/app/utils/functions/firebase_analytics/log_events.dart';

class AddTodoScreen extends ConsumerWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logScreen('TodoAddScreen');
      logEvent(
        name: 'todo_add_screen_open',
        parameters: {'screen': 'AddTodoScreen'},
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20), child: TodoAddForm()),
      ),
    );
  }
}
