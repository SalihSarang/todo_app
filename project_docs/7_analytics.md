# 7. Firebase Analytics

## Concept Overview
Firebase Analytics provides insight into user behavior. It tracks how users navigate the app and which features they use most.

## Key Components

### 1. Initialization
Analytics is initialized automatically with `firebase_core`. We access the instance via `FirebaseAnalytics.instance`.

### 2. Event Logging
We log standard and custom events to track specific actions:
- **`app_open`**: Logged automatically (and manually in `main.dart`).
- **`login`**: Logged when a user signs in (Email or Google).
- **`task_created`**: Logged when a new task is added.
- **`task_deleted`**: Logged when a task is removed.

Example Code:
```dart
await FirebaseAnalytics.instance.logEvent(
  name: 'task_created',
  parameters: {
    'task_name': taskName,
    'source': 'home_screen',
  },
);
```

### 3. Screen Tracking
We use `FirebaseAnalyticsObserver` in `MaterialApp` to automatically track screen views as the user navigates between routes (`/login`, `/home`).

## Review Questions & Answers
**Q: What is the purpose of custom parameters?**
A: Parameters provide context to an event. For example, for `task_deleted`, we might track whether it was deleted via a swipe or a button click, helping us understand UI usage patterns.

**Q: How do I view this data?**
A: Data is visible in the Firebase Console under the "Analytics" -> "Dashboard" or "Events" tab. Real-time data can be seen in "DebugView" if the device is configured for debugging.
