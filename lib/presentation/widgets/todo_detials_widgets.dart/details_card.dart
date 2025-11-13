import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/presentation/widgets/common/loading.dart';
import 'error_widget.dart';

class DetailsCard extends ConsumerWidget {
  final String id;
  const DetailsCard({super.key, required this.id});

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(String time24) {
    try {
      final parts = time24.split(':');
      if (parts.length != 2) return time24;

      final hour = int.parse(parts[0]);
      final minute = parts[1].padLeft(2, '0');

      if (hour == 0) {
        return '12:$minute AM';
      } else if (hour < 12) {
        return '$hour:$minute AM';
      } else if (hour == 12) {
        return '12:$minute PM';
      } else {
        return '${hour - 12}:$minute PM';
      }
    } catch (e) {
      return time24;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(todoDetailsProvider(id));

    return detailsAsync.when(
      data: (data) {
        return SizedBox(
          child: Card(
            color: Colors.black87,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.details,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  if (data.date != null || data.time != null) ...[
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white54),
                    const SizedBox(height: 12),
                    if (data.date != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(data.date!),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    if (data.date != null && data.time != null)
                      const SizedBox(height: 12),
                    if (data.time != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(data.time!),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                  ],
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
