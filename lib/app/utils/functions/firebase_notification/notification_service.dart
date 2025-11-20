import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('Background message received: ${message.messageId}');
}

class NotificationService {
  NotificationService();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _requestPermissionAndToken();
    await _configureForegroundPresentation();
    _listenForegroundMessages();
    _listenOpenedAppMessages();
  }

  Future<void> _requestPermissionAndToken() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('Permission status: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      final token = await _messaging.getToken();
      log('FCM token: $token');
    }
  }

  Future<void> _configureForegroundPresentation() {
    return _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      log('Foreground message: ${message.messageId}');
    });
  }

  void _listenOpenedAppMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Notification caused app open: ${message.messageId}');
    });
  }
}
