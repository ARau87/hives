import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Sign In', type: HivesAuthHeader)
Widget signInAuthHeader(BuildContext context) {
  return const Center(
    child: HivesAuthHeader(variant: HivesAuthHeaderVariant.signIn),
  );
}

@widgetbook.UseCase(name: 'Sign Up', type: HivesAuthHeader)
Widget signUpAuthHeader(BuildContext context) {
  return const Center(
    child: HivesAuthHeader(variant: HivesAuthHeaderVariant.signUp),
  );
}

@widgetbook.UseCase(name: 'Forgot Password', type: HivesAuthHeader)
Widget forgotPasswordAuthHeader(BuildContext context) {
  return const Center(
    child: HivesAuthHeader(variant: HivesAuthHeaderVariant.forgotPassword),
  );
}
