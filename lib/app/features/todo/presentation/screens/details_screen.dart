import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/todo_detials_widgets.dart/details_card.dart';
import 'package:todo_riverpod/app/utils/functions/firebase_analytics/log_events.dart';

class DetailsScreen extends ConsumerWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logScreen('TodoDetailsScreen');

    logEvent(
      name: 'todo_details_screen_opend',
      parameters: {'screen': 'TodoDetailsScreen'},
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: DetailsCard(id: id),
    );
  }
}
