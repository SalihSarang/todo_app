import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/presentation/screens/add_todo_screen.dart';
import 'package:todo_riverpod/utils/navigator.dart';
import 'package:todo_riverpod/presentation/widgets/home_screen_widgets/todo_list_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'HomeScreen',
      screenClass: 'HomeScreen',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),

      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(todoStateProvider),
        child: TodoListView(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(context: context, screen: AddTodoScreen()),

        child: const Icon(Icons.add_rounded, size: 35),
      ),
    );
  }
}
