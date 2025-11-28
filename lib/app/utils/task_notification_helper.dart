import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';
import 'package:todo_riverpod/app/utils/notification_constants.dart';
import 'package:todo_riverpod/app/utils/notification_service.dart';

class TaskNotificationHelper {
  static final Logger _logger = Logger();

  static Future<void> scheduleTaskNotifications(TodoModel task) async {
    try {
      if (task.date == null || task.time == null) {
        _logger.w('Task ${task.id} has no date/time, skipping notifications');
        return;
      }

      final DateTime? taskDateTime = _parseTaskDateTime(task.date!, task.time!);

      if (taskDateTime == null) {
        _logger.e('Failed to parse task date/time for task ${task.id}');
        return;
      }

      if (taskDateTime.isBefore(DateTime.now())) {
        _logger.w('Task ${task.id} is in the past, skipping notifications');
        return;
      }

      final notificationService = NotificationService();
      final baseId = task.id.hashCode;

      // Calculate times
      final exactTime = taskDateTime;
      final tenMinutesBefore = taskDateTime.subtract(
        const Duration(minutes: 10),
      );
      final thirtyMinutesBefore = taskDateTime.subtract(
        const Duration(minutes: 30),
      );

      _logger.i(
        'Calculating notification times for task ${task.id}:\n'
        '  Task Time: $taskDateTime\n'
        '  Exact: $exactTime\n'
        '  -10 min: $tenMinutesBefore\n'
        '  -30 min: $thirtyMinutesBefore',
      );

      // Schedule Exact Time
      await _scheduleReminder(
        notificationService,
        id: baseId + NotificationConstants.exactTimeOffset,
        title: '⏰ Task Due Now: ${task.title}',
        body: task.details.isNotEmpty ? task.details : 'Your task is due now!',
        scheduledDate: exactTime,
        payload: 'task_${task.id}_exact',
      );

      // Schedule 10 Minutes Before
      await _scheduleReminder(
        notificationService,
        id: baseId + NotificationConstants.tenMinutesOffset,
        title: '🔔 Task Due in 10 Minutes: ${task.title}',
        body: task.details.isNotEmpty
            ? task.details
            : 'Your task is due in 10 minutes!',
        scheduledDate: tenMinutesBefore,
        payload: 'task_${task.id}_10min',
      );

      // Schedule 30 Minutes Before
      await _scheduleReminder(
        notificationService,
        id: baseId + NotificationConstants.thirtyMinutesOffset,
        title: '📅 Task Due in 30 Minutes: ${task.title}',
        body: task.details.isNotEmpty
            ? task.details
            : 'Your task is due in 30 minutes!',
        scheduledDate: thirtyMinutesBefore,
        payload: 'task_${task.id}_30min',
      );

      _logger.i('Successfully scheduled notifications for task ${task.id}');
    } catch (e) {
      _logger.e('Error scheduling notifications for task ${task.id}: $e');
    }
  }

  static Future<void> _scheduleReminder(
    NotificationService service, {
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
  }) async {
    if (scheduledDate.isAfter(DateTime.now())) {
      await service.scheduleNotification(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        payload: payload,
      );
    }
  }

  static Future<void> cancelTaskNotifications(String taskId) async {
    try {
      final notificationService = NotificationService();
      final baseId = taskId.hashCode;

      await notificationService.cancelNotification(
        baseId + NotificationConstants.exactTimeOffset,
      );
      await notificationService.cancelNotification(
        baseId + NotificationConstants.tenMinutesOffset,
      );
      await notificationService.cancelNotification(
        baseId + NotificationConstants.thirtyMinutesOffset,
      );

      _logger.i('Cancelled all notifications for task $taskId');
    } catch (e) {
      _logger.e('Error cancelling notifications for task $taskId: $e');
    }
  }

  static DateTime? _parseTaskDateTime(DateTime date, String timeString) {
    try {
      timeString = timeString.trim();
      TimeOfDay? timeOfDay;

      if (timeString.contains(':')) {
        final parts = timeString.split(':');
        if (parts.length == 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1].split(' ')[0]);

          if (hour != null && minute != null) {
            if (timeString.toUpperCase().contains('PM') && hour < 12) {
              timeOfDay = TimeOfDay(hour: hour + 12, minute: minute);
            } else if (timeString.toUpperCase().contains('AM') && hour == 12) {
              timeOfDay = TimeOfDay(hour: 0, minute: minute);
            } else {
              timeOfDay = TimeOfDay(hour: hour, minute: minute);
            }
          }
        }
      }

      if (timeOfDay == null) {
        _logger.e('Failed to parse time string: $timeString');
        return null;
      }

      return DateTime(
        date.year,
        date.month,
        date.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
    } catch (e) {
      _logger.e('Error parsing task date/time: $e');
      return null;
    }
  }

  static Future<void> showTaskCreatedNotification(TodoModel task) async {
    try {
      await NotificationService().showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: '✅ Task Created',
        body: task.title,
        payload: 'task_${task.id}_created',
      );
      _logger.i('Showed task created notification for ${task.id}');
    } catch (e) {
      _logger.e('Error showing task created notification: $e');
    }
  }

  static Future<void> showTaskCompletedNotification(TodoModel task) async {
    try {
      await cancelTaskNotifications(task.id);
      await NotificationService().showTaskCompletionNotification(
        taskTitle: task.title,
      );
      _logger.i('Showed task completed notification for ${task.id}');
    } catch (e) {
      _logger.e('Error showing task completed notification: $e');
    }
  }
}
