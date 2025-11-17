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
      key: formKey,
      child: Column(
        children: [
          // Name
          CustomTextFormField(
            controller: nameController,
            label: 'Name',
            hint: 'Enter your name',
            validator: (value) => SignupValidators.validateName(value),
          ),
          const SizedBox(height: 20),

          // Email
          CustomTextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            hint: 'Enter your email',
            validator: (value) => SignupValidators.validateEmail(value),
          ),

          const SizedBox(height: 20),

          // Password
          CustomTextFormField(
            controller: passwordController,
            obscureText: true,
            maxLines: 1,
            label: 'Password',
            validator: (value) => SignupValidators.validatePassword(value),
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
