import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/custom_button.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/other_login_methods.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/login_option.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/sign_up_form.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/title_widget.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/register_user.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              const TitleWidget(),

              const SizedBox(height: 40),
              SignUpForm(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                nameController: _nameController,
                emailController: _emailController,
                phoneController: _phoneController,
                formKey: _formKey,
              ),
              const SizedBox(height: 30),

              CustomButton(
                onPressed: () {
                  registerUser(
                    formKey: _formKey,
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    comfirmPassword: _confirmPasswordController.text.trim(),
                    phone: _phoneController.text.trim(),
                    context: context,
                  );
                },
                child: const Text('Sign Up'),
              ),

              const SizedBox(height: 20),

              const OtherLoginMethods(),

              const SizedBox(height: 20),

              const LoginOption(),
            ],
          ),
        ),
      ),
    );
  }
}
