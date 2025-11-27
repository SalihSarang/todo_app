import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/google_auth/google_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user_auth/business/auth_loading_provider.dart';

class OtherLoginMethods extends ConsumerWidget {
  const OtherLoginMethods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authLoadingProvider);

    return Center(
      child: Column(
        children: [
          const Text("Or continue with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: isLoading
                    ? null
                    : () async {
                        ref.read(authLoadingProvider.notifier).state = true;
                        try {
                          final user = await GoogleAuthService()
                              .signInWithGoogle();
                          if (user != null && context.mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        } finally {
                          ref.read(authLoadingProvider.notifier).state = false;
                        }
                      },
                child: Opacity(
                  opacity: isLoading ? 0.5 : 1.0,
                  child: Image.asset(
                    'assets/google_icon.png',
                    height: 35,
                    width: 50,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
