import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Default loading indicator with honey color from the theme.
@widgetbook.UseCase(name: 'Default', type: HivesLoadingIndicator)
Widget loadingIndicatorDefault(BuildContext context) {
  return const Center(
    child: HivesLoadingIndicator(),
  );
}

/// Loading indicator with interactive size knob.
@widgetbook.UseCase(name: 'Custom Size', type: HivesLoadingIndicator)
Widget loadingIndicatorCustomSize(BuildContext context) {
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 48,
    min: 16,
    max: 96,
  );

  return Center(
    child: HivesLoadingIndicator(size: size),
  );
}

/// Loading indicator with adjustable stroke width.
@widgetbook.UseCase(name: 'Custom Stroke Width', type: HivesLoadingIndicator)
Widget loadingIndicatorCustomStroke(BuildContext context) {
  final strokeWidth = context.knobs.double.slider(
    label: 'Stroke Width',
    initialValue: 3.0,
    min: 1.0,
    max: 8.0,
  );

  return Center(
    child: HivesLoadingIndicator(size: 64, strokeWidth: strokeWidth),
  );
}
