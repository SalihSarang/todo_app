import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/utils/login_screen_functions/login_screen_validation.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String? errorMessage;
  final VoidCallback? onInputChanged;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    this.errorMessage,
    this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          CustomTextFormField(
            controller: emailController,
            label: 'Email',
            hint: 'Enter your email',
            validator: (value) => Validators.validateEmail(value),
            onChanged: (_) => onInputChanged?.call(),
          ),

          const SizedBox(height: 20),

          CustomTextFormField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter your password',
            validator: (value) => Validators.validatePassword(value),
            onChanged: (_) => onInputChanged?.call(),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
