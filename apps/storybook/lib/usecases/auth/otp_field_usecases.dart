import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesOTPField)
Widget otpFieldDefault(BuildContext context) {
  return const Center(child: HivesOTPField());
}

@widgetbook.UseCase(name: 'Error State', type: HivesOTPField)
Widget otpFieldError(BuildContext context) {
  return Center(
    child: HivesOTPField(
      hasError: context.knobs.boolean(
        label: 'Has Error',
        initialValue: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Callback', type: HivesOTPField)
Widget otpFieldWithCallback(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HivesOTPField(
          onComplete: (code) {
            debugPrint('OTP completed: $code');
          },
        ),
        const SizedBox(height: 16),
        const Text('Enter 6 digits — check debug console for callback'),
      ],
    ),
  );
}
