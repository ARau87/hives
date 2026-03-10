import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Empty', type: HivesDatePicker)
Widget hivesDatePickerEmpty(BuildContext context) {
  return const Center(
    child: SizedBox(
      width: 300,
      child: HivesDatePicker(
        label: 'Date of Birth',
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Filled', type: HivesDatePicker)
Widget hivesDatePickerFilled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesDatePicker(
        label: 'Inspection Date',
        selectedDate: DateTime(2025, 6, 15),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: HivesDatePicker)
Widget hivesDatePickerDisabled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesDatePicker(
        label: 'Locked Date',
        selectedDate: DateTime(2025, 1, 1),
        isEnabled: false,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Error', type: HivesDatePicker)
Widget hivesDatePickerError(BuildContext context) {
  return const Center(
    child: SizedBox(
      width: 300,
      child: HivesDatePicker(
        label: 'Required Date',
        errorText: 'Please select a date',
      ),
    ),
  );
}
