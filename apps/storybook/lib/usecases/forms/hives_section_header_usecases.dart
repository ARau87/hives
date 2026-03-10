import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Standalone', type: HivesSectionHeader)
Widget hivesSectionHeaderStandalone(BuildContext context) {
  return const Center(
    child: SizedBox(
      width: 300,
      child: HivesSectionHeader(title: 'My Hives'),
    ),
  );
}

@widgetbook.UseCase(name: 'With Action', type: HivesSectionHeader)
Widget hivesSectionHeaderWithAction(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesSectionHeader(
        title: 'Recent Inspections',
        actionLabel: 'See All',
        onAction: () => debugPrint('See All tapped'),
      ),
    ),
  );
}
