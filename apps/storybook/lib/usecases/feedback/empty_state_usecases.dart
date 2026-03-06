import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'No Locations', type: HivesEmptyState)
Widget emptyStateNoLocations(BuildContext context) {
  return HivesEmptyState.noLocations(
    ctaLabel: 'Add Location',
    onCta: () {},
  );
}

@widgetbook.UseCase(name: 'No Hives', type: HivesEmptyState)
Widget emptyStateNoHives(BuildContext context) {
  return HivesEmptyState.noHives(
    ctaLabel: 'Add Hive',
    onCta: () {},
  );
}

@widgetbook.UseCase(name: 'No Tasks', type: HivesEmptyState)
Widget emptyStateNoTasks(BuildContext context) {
  return HivesEmptyState.noTasks();
}

@widgetbook.UseCase(name: 'No Results', type: HivesEmptyState)
Widget emptyStateNoResults(BuildContext context) {
  return HivesEmptyState.noResults();
}
