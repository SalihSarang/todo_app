import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/custom_button.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/other_login_methods.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/login_form.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/signup_page_option.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/welcome_icon.dart';
import 'package:todo_riverpod/app/features/user_auth/utils/user_login_fuction.dart';

class LoginScreenBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginScreenBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            WelcomeIcon(),

            const SizedBox(height: 40),

            LoginForm(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
            ),

            CustomButton(
              onPressed: () => userLogin(
                formKey: formKey,
                email: emailController.text,
                password: passwordController.text,
              ),
              child: const Text("Login"),
            ),

            const SizedBox(height: 20),

            OtherLoginMethods(),

            const SizedBox(height: 20),

            SignupPageOption(),
          ],
        ),
      ),
    );
  }
}
