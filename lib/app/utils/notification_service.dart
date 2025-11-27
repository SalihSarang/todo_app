import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final Logger _logger = Logger();

  Future<void> initialize() async {
    try {
      tz_data.initializeTimeZones();
      try {
        final timeZoneName = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));
        _logger.i('Local timezone set to: $timeZoneName');
      } catch (e) {
        _logger.e('Could not get local timezone, defaulting to UTC: $e');
        tz.setLocalLocation(tz.UTC);
      }

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      const InitializationSettings initializationSettings =
          InitializationSettings(android: androidSettings, iOS: iosSettings);

      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await _notificationsPlugin.getNotificationAppLaunchDetails();

      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        final response = notificationAppLaunchDetails!.notificationResponse;
        if (response != null) {
          _logger.i('App launched from notification: ${response.payload}');
          _onNotificationTapped(response);
        }
      }

      await _requestPermissions();

      _logger.i('Notification service initialized successfully');
    } catch (e) {
      _logger.e('Error initializing notification service: $e');
    }
  }

  Future<void> _requestPermissions() async {
    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }

      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      if (iosImplementation != null) {
        await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    } catch (e) {
      _logger.e('Error requesting notification permissions: $e');
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    _logger.i('Notification tapped with payload: ${response.payload}');
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'default_channel_v2',
            'Default Notifications',
            channelDescription: 'Default notification channel for the app',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: true,
          );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );

      _logger.i('Notification shown: $title');
    } catch (e) {
      _logger.e('Error showing notification: $e');
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'scheduled_channel_v2',
            'Scheduled Notifications',
            channelDescription: 'Channel for scheduled notifications',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: true,
          );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _convertToTZDateTime(scheduledDate),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      _logger.i(
        'Notification scheduled successfully:\n'
        '  ID: $id\n'
        '  Title: $title\n'
        '  Scheduled Time: $scheduledDate\n'
        '  Payload: $payload',
      );
    } catch (e) {
      _logger.e('Error scheduling notification: $e');
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
      _logger.i('Notification cancelled: $id');
    } catch (e) {
      _logger.e('Error cancelling notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _notificationsPlugin.cancelAll();
      _logger.i('All notifications cancelled');
    } catch (e) {
      _logger.e('Error cancelling all notifications: $e');
    }
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await _notificationsPlugin.pendingNotificationRequests();
    } catch (e) {
      _logger.e('Error getting pending notifications: $e');
      return [];
    }
  }

  tz.TZDateTime _convertToTZDateTime(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }

  Future<void> showTaskReminder({
    required int taskId,
    required String taskTitle,
    String? taskDescription,
  }) async {
    await showNotification(
      id: taskId,
      title: 'Task Reminder: $taskTitle',
      body: taskDescription ?? 'You have a pending task',
      payload: 'task_$taskId',
    );
  }

  Future<void> scheduleTaskReminder({
    required int taskId,
    required String taskTitle,
    required DateTime reminderTime,
    String? taskDescription,
  }) async {
    await scheduleNotification(
      id: taskId,
      title: 'Task Reminder: $taskTitle',
      body: taskDescription ?? 'You have a pending task',
      scheduledDate: reminderTime,
      payload: 'task_$taskId',
    );
  }

  Future<void> showTaskCompletionNotification({
    required String taskTitle,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Task Completed! ',
      body: 'You completed: $taskTitle',
      payload: 'task_completed',
    );
  }
}
