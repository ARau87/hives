import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'With Pin', type: HivesMapPreviewWidget)
Widget mapPreviewWithPin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesMapPreviewWidget(hasPin: true, onTap: () {}),
  );
}

@widgetbook.UseCase(name: 'No Pin Set', type: HivesMapPreviewWidget)
Widget mapPreviewNoPinSet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesMapPreviewWidget(hasPin: false, onTap: () {}),
  );
}

@widgetbook.UseCase(name: 'Loading', type: HivesMapPreviewWidget)
Widget mapPreviewLoading(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesMapPreviewWidget(isLoading: true),
  );
}
