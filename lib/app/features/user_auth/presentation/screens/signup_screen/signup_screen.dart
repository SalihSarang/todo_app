import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_riverpod/app/features/user_auth/data/repositories/fire_base_auth/register_user.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/custom_button.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/common/other_login_methods.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/login_option.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/sign_up_form.dart';
import 'package:todo_riverpod/app/features/user_auth/presentation/widgets/signup_widgets/title_widget.dart';
import 'package:todo_riverpod/app/features/user_auth/business/auth_loading_provider.dart';

final signupErrorProvider = StateProvider.autoDispose<String?>((ref) => null);

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authError = ref.watch(signupErrorProvider);
    final isLoading = ref.watch(authLoadingProvider);

    void setError(String? message) {
      ref.read(signupErrorProvider.notifier).state = message;
    }

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
                errorMessage: authError,
                onInputChanged: () => setError(null),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: isLoading
                    ? () {}
                    : () {
                        registerUser(
                          formKey: _formKey,
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          comfirmPassword: _confirmPasswordController.text
                              .trim(),
                          phone: _phoneController.text.trim(),
                          context: context,
                          ref: ref,
                          onError: setError,
                        );
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Sign Up'),
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
