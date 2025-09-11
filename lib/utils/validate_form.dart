import 'package:flutter/material.dart';

bool validateForm(GlobalKey<FormState> key) {
  if (key.currentState!.validate()) return true;
  return false;
}
