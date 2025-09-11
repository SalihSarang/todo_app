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
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(todoStateProvider),
        child: TodoListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(context: context, screen: AddTodoScreen()),
        child: Icon(Icons.add_rounded, size: 35),
      ),
    );
  }
}
