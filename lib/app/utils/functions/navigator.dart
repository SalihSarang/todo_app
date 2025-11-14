import 'package:flutter/material.dart';

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void pushReplacementTo({
  required BuildContext context,
  required Widget screen,
}) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
}
