// app/utils/functions/handle_initial_message.dart
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void handleInitialMessage(BuildContext context, RemoteMessage? initialMessage) {
  // 1. Check if a message exists. If not, do nothing.
  if (initialMessage == null) {
    return;
  }

  final data = initialMessage.data;

  // 2. Perform navigation based on the 'action' field in the payload data
  switch (data['action']) {
    case 'open_home':
      // Use pushReplacementNamed to prevent the user from going back to the splash screen
      Navigator.pushReplacementNamed(context, '/home');
      break;

    case 'open_login':
      Navigator.pushReplacementNamed(context, '/login');
      break;

    default:
      // Default action: stay on the current route (likely the splash screen) or navigate to a default screen.
      // Since the app starts on '/', staying on the current route is fine.
      break;
  }
}
