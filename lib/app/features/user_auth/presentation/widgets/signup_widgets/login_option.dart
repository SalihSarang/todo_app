import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/login_screen/login_screen.dart';
import 'package:todo_riverpod/app/utils/functions/navigator.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: () =>
              pushReplacementTo(context: context, screen: LoginScreen()),
          child: const Text("Login"),
        ),
      ],
    );
  }
}
