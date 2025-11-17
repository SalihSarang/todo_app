import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/business/todo_provider.dart';
import 'package:todo_riverpod/app/features/todo/presentation/screens/add_todo_screen.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/home_screen_widgets/custom_app_bar.dart';
import 'package:todo_riverpod/app/utils/functions/navigator.dart';
import '../../../user/presentation/screen/user_profile_screen/user_profile_screen.dart'
    show UserProfileScreen;
import 'package:todo_riverpod/app/features/todo/presentation/widgets/home_screen_widgets/todo_list_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Todos',
        onProfileTap: () =>
            navigateTo(context: context, screen: const UserProfileScreen()),
      ),

      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(todoStateProvider),
        child: const TodoListView(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            navigateTo(context: context, screen: const AddTodoScreen()),
        child: const Icon(Icons.add_rounded, size: 35),
      ),
    );
  }
}
