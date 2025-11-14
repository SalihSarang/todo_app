import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/signup_screen/signup_screen.dart';
import 'package:todo_riverpod/app/utils/functions/navigator.dart';

class SignupPageOption extends StatelessWidget {
  const SignupPageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () => navigateTo(context: context, screen: SignupScreen()),
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
