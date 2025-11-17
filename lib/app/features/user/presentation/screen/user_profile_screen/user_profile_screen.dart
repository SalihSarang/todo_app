import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_provider.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/custom_appbar.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_profile_screen_body.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'User Profile'),

      body: userState.when(
        data: (user) => UserProfileScreenBody(user: user),

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, st) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
