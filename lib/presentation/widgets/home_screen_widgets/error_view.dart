import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView({super.key, required this.error});

  final Object error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: const Text(
            'Something Went Wrong, Please Try again',
            style: TextStyle(fontSize: 25),
          ),
        ),
        ElevatedButton(
          onPressed: () => ref.refresh(todoStateProvider),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
