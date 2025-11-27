import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/login_user.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/custom_button.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/other_login_methods.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/login_form.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/signup_page_option.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/login_widgets/welcome_icon.dart';
import 'package:todo_riverpod/app/features/user_auth/business/auth_loading_provider.dart';

final loginErrorProvider = StateProvider.autoDispose<String?>((ref) => null);

class LoginScreenBody extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final authError = ref.watch(loginErrorProvider);
    final isLoading = ref.watch(authLoadingProvider);

    void clearError() {
      ref.read(loginErrorProvider.notifier).state = null;
    }

    void setError(String? message) {
      ref.read(loginErrorProvider.notifier).state = message;
    }

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
              errorMessage: authError,
              onInputChanged: clearError,
            ),
            CustomButton(
              onPressed: isLoading
                  ? () {}
                  : () => loginUser(
                      formKey: formKey,
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                      ref: ref,
                      onError: setError,
                    ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Login"),
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
