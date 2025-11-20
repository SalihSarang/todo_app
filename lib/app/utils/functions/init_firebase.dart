import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_notification/notification_service.dart';

Future<void> initFirebaseNotification() async {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final notificationService = NotificationService();
  await notificationService.initialize();
}
