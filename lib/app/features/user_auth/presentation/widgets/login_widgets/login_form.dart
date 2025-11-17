import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/utils/login_screen_functions/login_screen_validation.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: emailController,
            label: 'Email',
            hint: 'Enter your email',
            validator: (value) => Validators.validateEmail(value),
          ),

          const SizedBox(height: 20),

          CustomTextFormField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter your password',
            validator: (value) => Validators.validatePassword(value),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
