import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/presentation/widgets/common/loading.dart';
import 'error_widget.dart';

class DetailsCard extends ConsumerWidget {
  final String id;
  const DetailsCard({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(todoDetailsProvider(id));

    return detailsAsync.when(
      data: (data) {
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: Card(
            color: Colors.black87,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title : ${data.title}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Details : ${data.details}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const LoadingState(),
      error: (error, _) => DetailsErrorView(
        error: error,
        onRetry: () => ref.refresh(todoDetailsProvider(id)),
      ),
    );
  }
}
