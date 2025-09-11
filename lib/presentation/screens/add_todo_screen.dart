import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/presentation/widgets/add_todo_widgets/todo_add_form.dart';

class AddTodoScreen extends ConsumerWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [TodoAddForm()]),
      ),
    );
  }
}
