import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default (or)', type: HivesDividerWithLabel)
Widget dividerWithLabelDefault(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: HivesDividerWithLabel(label: 'or'),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Label', type: HivesDividerWithLabel)
Widget dividerWithLabelCustom(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: HivesDividerWithLabel(label: 'continue with'),
    ),
  );
}
