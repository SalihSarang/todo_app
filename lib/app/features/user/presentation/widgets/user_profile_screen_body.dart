import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/circle_avatar_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/log_out_button_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_id_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_profile_row_widget.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

class UserProfileScreenBody extends StatelessWidget {
  final User user;
  const UserProfileScreenBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarWidget(),
          const SizedBox(height: 20),
          ProfileDetailRow(
            icon: Icons.person_outline,
            label: 'USER NAME',
            value: user.displayName,
          ),
          ProfileDetailRow(
            icon: Icons.mail_outline,
            label: 'EMAIL ADDRESS',
            value: user.email,
          ),
          UserIdWidget(userId: user.uid),
          LogOutButton(),
        ],
      ),
    );
  }
}
