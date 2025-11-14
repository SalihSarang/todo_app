import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user/utils/show_logout_dialog.dart';
import 'package:todo_riverpod/app/features/user/utils/show_logout_success.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onConfirmLogout() {
      showLogoutSuccess(context);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => showLogoutDialog(context, onConfirmLogout),
          icon: const Icon(Icons.logout, size: 20),
          label: const Text(
            'Log Out',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
