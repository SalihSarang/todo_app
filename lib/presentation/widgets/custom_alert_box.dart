import 'package:flutter/material.dart';

class DeleteTodoDialog extends StatelessWidget {
  final String todoName;
  final VoidCallback onConfirm;

  const DeleteTodoDialog({
    super.key,
    required this.todoName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Todo'),
      content: Text('Are you sure you want to delete "$todoName"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();

            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
