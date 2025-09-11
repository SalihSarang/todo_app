import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/data/model/todo_model.dart';
import 'package:todo_riverpod/presentation/widgets/common/custom_alert_box.dart';

class TodoCard extends ConsumerWidget {
  final TodoModel todo;
  const TodoCard({super.key, required this.todo});

  @override
  build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 80,
      child: Card(
        color: Colors.black87,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListTile(
              title: Text(todo.title, style: TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      ref
                          .read(todoStateProvider.notifier)
                          .toggleCompleted(todo.id);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteTodoDialog(
                          todoName: todo.title,
                          onConfirm: () async {
                            await ref
                                .read(todoStateProvider.notifier)
                                .deleteTodo(todo.id);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
