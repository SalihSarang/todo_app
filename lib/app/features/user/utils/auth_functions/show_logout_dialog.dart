import 'package:flutter/material.dart';
import 'package:todo_riverpod/app/features/user/presentation/widgets/log_out_alert_box_widget.dart';

void showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutConfirmationDialog(onConfirmLogout: onConfirm);
    },
  );
}
