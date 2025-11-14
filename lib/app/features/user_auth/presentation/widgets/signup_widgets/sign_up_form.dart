import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const SignUpForm({
    super.key,
    required this.passwordController,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Name
          CustomTextFormField(
            controller: nameController,
            label: 'Name',
            hint: 'Enter your name',
          ),
          const SizedBox(height: 20),

          // Email
          CustomTextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            hint: 'Enter your email',
          ),

          const SizedBox(height: 20),

          // Password
          CustomTextFormField(
            controller: passwordController,
            obscureText: true,
            maxLines: 1,
            label: 'Password',
          ),

          const SizedBox(height: 20),

          // Confirm Password
          CustomTextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            maxLines: 1,
            label: 'Confirm Password',
          ),

          const SizedBox(height: 20),

          // Phone
          CustomTextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            label: 'Phone',
          ),
        ],
      ),
    );
  }
}
