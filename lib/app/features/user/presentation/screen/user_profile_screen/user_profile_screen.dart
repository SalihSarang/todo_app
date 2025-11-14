import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/custom_appbar.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_profile_screen_body.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'User Profile'),
      body: UserProfileScreenBody(user: user),
    );
  }
}
