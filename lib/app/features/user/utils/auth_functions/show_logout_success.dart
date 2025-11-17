import 'package:flutter/material.dart';

void showLogoutSuccess(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('You have been successfully logged out.'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ),
  );
}
