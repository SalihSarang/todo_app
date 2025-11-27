import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> logEvent({
  required String name,
  Map<String, Object>? parameters,
}) async {
  await FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
}

Future<void> logScreen(String screenName) async {
  await FirebaseAnalytics.instance.logScreenView(screenName: screenName);
}
