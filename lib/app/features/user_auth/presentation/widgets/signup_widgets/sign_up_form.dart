import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/utils/signup_screen/signup_validations.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final String? errorMessage;
  final VoidCallback? onInputChanged;

  const SignUpForm({
    super.key,
    required this.passwordController,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
    required this.confirmPasswordController,
    this.errorMessage,
    this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Name
          CustomTextFormField(
            controller: nameController,
            label: 'Name',
            hint: 'Enter your name',
            validator: (value) => SignupValidators.validateName(value),
            onChanged: (_) => onInputChanged?.call(),
          ),
          const SizedBox(height: 20),

          // Email error message + field
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
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            hint: 'Enter your email',
            validator: (value) => SignupValidators.validateEmail(value),
            onChanged: (_) => onInputChanged?.call(),
          ),

          const SizedBox(height: 20),

          // Password
          CustomTextFormField(
            controller: passwordController,
            obscureText: true,
            maxLines: 1,
            label: 'Password',
            validator: (value) => SignupValidators.validatePassword(value),
            onChanged: (_) => onInputChanged?.call(),
          ),

          const SizedBox(height: 20),

          // Confirm Password
          CustomTextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            maxLines: 1,
            label: 'Confirm Password',
            validator: (value) => SignupValidators.validateConfirmPassword(
              value,
              passwordController.text.trim(),
            ),
            onChanged: (_) => onInputChanged?.call(),
          ),

          const SizedBox(height: 20),

          // Phone
          // CustomTextFormField(
          //   controller: phoneController,
          //   keyboardType: TextInputType.phone,
          //   maxLength: 10,
          //   label: 'Phone',
          //   validator: (value) => SignupValidators.validatePhone(value),
          // ),
        ],
      ),
    );
  }
}
