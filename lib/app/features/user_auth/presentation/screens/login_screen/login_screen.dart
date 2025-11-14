import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenBody(
        emailController: _emailController,
        passwordController: _passwordController,
        formKey: _formKey,
      ),
    );
  }
}
