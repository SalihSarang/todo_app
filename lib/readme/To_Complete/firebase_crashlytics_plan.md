Firebase Crashlytics Implementation Plan
========================================

1. Setup & Initialization
-------------------------
- Add `firebase_crashlytics` to `pubspec.yaml` along with `firebase_core`.
- Configure the Firebase project’s Crashlytics section (accept terms, enable data sharing).
- Initialize Crashlytics in `main.dart`:
  - Call `FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError`.
  - Use `runZonedGuarded` to capture uncaught asynchronous errors.
- For Android: update `android/app/build.gradle` with `apply plugin: 'com.google.firebase.crashlytics'` and enable crashlytics in the `buildTypes`.
- For iOS: ensure the Crashlytics run script is added in Xcode build phases.
- Verify setup by forcing a test crash and checking the Firebase console.

2. Understanding Crash Reports
------------------------------
- Each crash report includes:
  - **Stack trace**: call stack at the moment of the crash (Dart + native layers).
  - **Device info**: OS version, model, localization, app version/build.
  - **Breadcrumbs / logs**: custom logs leading up to the crash.
- Use the Crashlytics dashboard to group crashes by issue, see frequency, and affected users.
- Prioritize based on crash-free users % and app versions impacted.

3. Customizing Error Handling
-----------------------------
3.a Logging Non-Fatal Errors
- Use `FirebaseCrashlytics.instance.recordError(error, stack, fatal: false)` for handled exceptions (e.g., repository failures, API errors).
- Wrap critical operations (auth, Firestore writes, uploads) with try/catch and log exceptions to capture context without crashing users.

3.b Setting Custom Keys
- Call `FirebaseCrashlytics.instance.setCustomKey('current_screen', 'HomeScreen')` or similar keys for user flows.
- Define keys for:
  - Feature flags (e.g., `'new_todo_flow': true`).
  - Important model IDs (todo ID, user ID hashed/anonymized).
  - App state markers (e.g., `'is_online': false`).
- Keys act as filters in the console to slice crash data quickly.

3.c Attaching User Information
- When the user authenticates, call:
  - `setUserIdentifier(userId)` (use UID or anonymized hash).
  - `setCustomKey('user_email', maskedEmail)` if needed.
- Helps correlate crashes to specific accounts while respecting privacy.

4. Using Crashlytics for Stability
----------------------------------
- Monitor crash-free users metric; aim for > 99.5% before releases.
- Use version filters to ensure new builds stay stable before rollout.
- Combine Crashlytics with Analytics funnels:
  - Detect if crashes correlate with certain events (e.g., `todo_created`).
- Create a triage routine:
  - Review new issues daily.
  - Assign severity/priority.
  - Link issues to bug tracker tasks.
- After fixes, release a new build and confirm issue counts drop (Crashlytics automatically marks resolved issues once no new reports arrive).

5. Next Steps & Checklist
-------------------------
- [ ] Add Crashlytics dependency and platform configs.
- [ ] Wire up Flutter/global error handlers.
- [ ] Implement helper for logging non-fatal errors with context.
- [ ] Define custom keys (screen, feature flag, entity IDs).
- [ ] Attach user identifiers after login.
- [ ] Force test crash to validate reporting.
- [ ] Establish monitoring + triage workflow for ongoing stability tracking.

