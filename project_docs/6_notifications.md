# 6. Notifications (Push & Local)

## Concept Overview
This module engages users through two types of notifications:
1.  **Push Notifications (FCM)**: Sent from the server (Firebase Console) to the device.
2.  **Local Notifications**: Scheduled locally on the device for task reminders.

## Key Components

### 1. Firebase Cloud Messaging (FCM)
- **Setup**: Configured in `firebase_notification/notification_service.dart`.
- **Permissions**: Requests permission on iOS/Android 13+.
- **Token**: Generates a unique FCM token for the device, which can be used to target specific users.
- **Handling**:
    - **Foreground**: Listens to `FirebaseMessaging.onMessage`.
    - **Background/Terminated**: Handled by `firebaseMessagingBackgroundHandler`.

### 2. Local Notifications (`flutter_local_notifications`)
- **Purpose**: Used for task reminders (e.g., "Task due in 10 minutes").
- **Scheduling**: We use `zonedSchedule` to trigger notifications at precise times even if the app is closed.
- **Task Integration**: When a task is created/updated, `TaskNotificationHelper` calculates reminder times (Exact, -10 min, -30 min) and schedules them.

### 3. Timezones
We use the `timezone` package to ensure notifications fire at the correct local time, regardless of the user's location.

## Review Questions & Answers
**Q: What is the difference between Push and Local notifications?**
A: Push notifications originate from a remote server (internet required). Local notifications are scheduled by the app itself on the device (no internet required once scheduled).

**Q: How do we handle notifications when the app is in the foreground?**
A: By default, FCM notifications might not show a system alert in the foreground. We listen to the stream and can manually show a local notification or an in-app dialog to alert the user.
