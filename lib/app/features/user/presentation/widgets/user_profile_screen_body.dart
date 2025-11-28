import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_provider.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/circle_avatar_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/log_out_button_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_id_widget.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/user_profile_row_widget.dart';
import 'package:todo_riverpod/app/features/user_auth/data/model/user_model.dart';

class UserProfileScreenBody extends ConsumerWidget {
  final UserModel user;

  const UserProfileScreenBody({super.key, required this.user});

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new $title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarWidget(),
          const SizedBox(height: 20),
          ProfileDetailRow(
            icon: Icons.person_outline,
            label: 'USER NAME',
            value: user.name,
            onEdit: () => _showEditDialog(context, ref, 'Name', user.name, (
              newValue,
            ) {
              ref.read(profileNotifierProvider.notifier).updateName(newValue);
            }),
          ),
          ProfileDetailRow(
            icon: Icons.mail_outline,
            label: 'EMAIL ADDRESS',
            value: user.email,
          ),
          ProfileDetailRow(
            icon: Icons.location_on_outlined,
            label: 'ADDRESS',
            value: user.address ?? 'No address set',
            onEdit: () => _showEditDialog(
              context,
              ref,
              'Address',
              user.address ?? '',
              (newValue) {
                ref
                    .read(profileNotifierProvider.notifier)
                    .updateAddress(newValue);
              },
            ),
          ),
          UserIdWidget(userId: user.uid),
          LogOutButton(),
        ],
      ),
    );
  }
}
