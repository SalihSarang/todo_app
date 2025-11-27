import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_provider.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/custom_appbar.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_profile_screen_body.dart';
import 'package:todo_riverpod/app/utils/functions/firebase_analytics/log_events.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(profileNotifierProvider);

    logScreen('UserProfileScreen');
    logEvent(
      name: 'profile_screen_opend',
      parameters: {'screen': 'ProfileScreen'},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'User Profile'),

      body: userState.when(
        data: (user) => ListView(
          children: [
            UserProfileScreenBody(user: user),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  throw Exception("CRASHLYTICS TEST: Forced Fatal Crash");
                },
                child: const Text('FORCE CRASHLYTICS CRASH'),
              ),
            ),
          ],
        ),

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, st) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
