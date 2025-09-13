import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/presentation/widgets/todo_detials_widgets.dart/details_card.dart';

class DetailsScreen extends ConsumerWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: DetailsCard(id: id),
    );
  }
}
