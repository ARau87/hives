import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesDangerButton)
Widget dangerButtonDefault(BuildContext context) {
  return Center(
    child: HivesDangerButton(label: 'Delete Hive', onPressed: () {}),
  );
}

@widgetbook.UseCase(name: 'Loading', type: HivesDangerButton)
Widget dangerButtonLoading(BuildContext context) {
  return const Center(
    child: HivesDangerButton(
      label: 'Deleting...',
      onPressed: _noop,
      isLoading: true,
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: HivesDangerButton)
Widget dangerButtonDisabled(BuildContext context) {
  return const Center(
    child: HivesDangerButton(
      label: 'Delete',
      onPressed: _noop,
      isEnabled: false,
    ),
  );
}

void _noop() {}
