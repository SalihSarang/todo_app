# 8. Crashlytics & Debugging

## Concept Overview
Firebase Crashlytics is a real-time crash reporting tool that helps you track, prioritize, and fix stability issues that erode app quality.

## Key Components

### 1. Setup
- **Flutter Error Handling**: We override `FlutterError.onError` to send Flutter-level errors (like layout overflows or widget exceptions) to Crashlytics.
- **Async Error Handling**: We use `runZonedGuarded` in `main.dart` to catch errors that happen in asynchronous code (like Futures or Streams) that would otherwise crash the app silently.

### 2. Custom Logging
We can record non-fatal errors (exceptions that don't crash the app but are still bugs) using:
```dart
FirebaseCrashlytics.instance.recordError(error, stackTrace);
```
We use this in our `try-catch` blocks (e.g., during login or database fetches) to monitor failure rates.

### 3. Fatal Crashes
We added a "Force Crash" button in the profile screen for testing purposes:
```dart
FirebaseCrashlytics.instance.crash();
```
This forces the app to terminate, allowing us to verify that the crash report appears in the Firebase Console.

## Review Questions & Answers
**Q: What is the difference between a fatal and non-fatal error?**
A: A **fatal** error causes the app to close/crash immediately. A **non-fatal** error is an exception that was caught (e.g., inside a `try-catch`) but is still reported so developers know something went wrong.

**Q: Why use `runZonedGuarded`?**
A: It creates a protective zone around the entire app execution. If an unhandled exception occurs anywhere in that zone (even in background async tasks), it is caught by the zone's error handler, allowing us to report it to Crashlytics before the app dies.
