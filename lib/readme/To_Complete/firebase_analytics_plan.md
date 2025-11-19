Firebase Analytics Implementation Plan
======================================

1. Introduction / Setup
-----------------------
- Enable Firebase Analytics in the Firebase console for the project.
- Add the `firebase_analytics` Flutter plugin alongside `firebase_core`.
- Initialize Analytics in `main.dart` (e.g., keep a global `FirebaseAnalytics` instance and an observer for navigation).
- Document the key product questions Analytics should answer (user retention, feature usage, conversion funnels).

2. Logging Events
-----------------
2.a Custom Events
- Define a list of app-specific events (e.g., `todo_created`, `todo_completed`, `profile_image_updated`, `auth_logout`).
- For each event, define required parameters (e.g., todo priority, completion time).
- Implement helper functions (e.g., `AnalyticsService.logTodoCreated(...)`) to keep logging centralized.
- Ensure events fire at the appropriate points in the business logic (e.g., inside notifiers/repositories after successful actions).
- Test using `DebugView` in Firebase Analytics to confirm events are received.

2.b Predefined Events
- Identify relevant predefined events (e.g., `login`, `sign_up`, `purchase`, `tutorial_complete`).
- Use the names and parameter schemas provided by Firebase for consistency.
- Map existing user flows to these events (login screen ⇒ `login`, signup screen ⇒ `sign_up`, onboarding tips ⇒ `tutorial_complete`).
- Verify via DebugView that Firebase groups them correctly and populates default dashboards.

3. Analyzing Data
-----------------
3.a User Properties
- Determine persistent attributes to track (e.g., account type, preferred theme, notification opt-in).
- Set properties using `setUserProperty` when state changes or upon login.
- Use properties to filter audiences in Firebase Analytics and downstream tools.

3.b Engagement Metrics
- Review built-in engagement reports (user engagement time, screen views).
- Add a `FirebaseAnalyticsObserver` to navigation to automatically log screen transitions.
- For key screens (todo list, add todo, profile), verify events include screen names for funnel analysis.

3.c Conversion Metrics
- Define conversion events (e.g., `todo_completed`, `profile_setup_done`, `cloudinary_upload_success`).
- Mark these events as conversions in the Firebase console.
- Build funnels (e.g., `login` → `todo_created` → `todo_completed`) to monitor drop-off.
- Share dashboards or automated exports (BigQuery) with stakeholders for ongoing review.

4. Next Steps & Checklist
-------------------------
- [ ] Add plugin dependencies and initialize Analytics.
- [ ] Implement an `AnalyticsService` wrapper for custom events/properties.
- [ ] Instrument predefined events in auth/onboarding flows.
- [ ] Test logging via DebugView.
- [ ] Configure conversion events and audiences in Firebase console.
- [ ] Document dashboards or reports for regular monitoring.

