import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/screens/login_screen/login_screen.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/custom_button.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/other_login_methods.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/sign_up_form.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/title_widget.dart';
import 'package:todo_riverpod/app/utils/functions/navigator.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';

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

              // Title
              TitleWidget(),

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

              // Sign-Up Button
              CustomButton(
                onPressed: () {
                  // Collect user inputs
                  // final name = _nameController.text.trim();
                  // final email = _emailController.text.trim();
                  // final password = _passwordController.text.trim();
                  // final confirmPassword = _confirmPasswordController.text
                  //     .trim();
                  // final phone = _phoneController.text.trim();
                },
                child: Text('Sign Up'),
              ),

              const SizedBox(height: 20),

              // Social Signup
              OtherLoginMethods(),

              const SizedBox(height: 20),

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => pushReplacementTo(
                      context: context,
                      screen: LoginScreen(),
                    ),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
