import 'dart:developer';
import 'package:todo_riverpod/main.dart';

Future<void> logTaskCreated({required String taskName}) async {
  await MyApp.analytics.logEvent(
    name: 'task_created',
    parameters: {'task_name': taskName, 'list_source': 'main_list'},
  );
  log('Analytics: task_created sent for: $taskName');
}

Future<void> logTaskDeleted({required String taskId}) async {
  await MyApp.analytics.logEvent(
    name: 'task_deleted',
    parameters: {'task_id': taskId, 'deletion_method': 'swipe_or_button'},
  );
  log('Analytics: task_deleted sent for ID: $taskId');
}
