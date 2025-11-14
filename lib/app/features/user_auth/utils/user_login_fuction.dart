import 'package:flutter/cupertino.dart';

void userLogin({
  required GlobalKey<FormState> formKey,
  required String email,
  required String password,
}) {
  if (formKey.currentState!.validate()) {}
}
