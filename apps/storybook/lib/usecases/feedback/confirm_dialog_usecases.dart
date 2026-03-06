import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Danger Variant', type: HivesConfirmDialog)
Widget confirmDialogDanger(BuildContext context) {
  return HivesConfirmDialog(
    icon: Icons.delete_forever,
    title: 'Delete this hive?',
    body: 'This action cannot be undone. All inspection data will be lost.',
    confirmLabel: 'Delete',
    onConfirm: () {},
    variant: HivesConfirmDialogVariant.danger,
  );
}

@widgetbook.UseCase(name: 'Warning Variant', type: HivesConfirmDialog)
Widget confirmDialogWarning(BuildContext context) {
  return HivesConfirmDialog(
    icon: Icons.warning_amber,
    title: 'Reset all settings?',
    body: 'Your preferences will be restored to defaults.',
    confirmLabel: 'Reset',
    onConfirm: () {},
    variant: HivesConfirmDialogVariant.warning,
  );
}
