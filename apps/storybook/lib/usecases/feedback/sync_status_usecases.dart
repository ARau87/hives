import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Shows all four sync states side by side for comparison.
@widgetbook.UseCase(name: 'All States', type: SyncStatusIndicator)
Widget syncStatusAllStates(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SyncStatusIndicator(state: SyncState.synced),
        SizedBox(height: AppSpacing.lg),
        SyncStatusIndicator(state: SyncState.syncing),
        SizedBox(height: AppSpacing.lg),
        SyncStatusIndicator(state: SyncState.offline),
        SizedBox(height: AppSpacing.lg),
        SyncStatusIndicator(state: SyncState.error),
      ],
    ),
  );
}

/// Single sync status indicator with interactive state selection.
@widgetbook.UseCase(name: 'Interactive', type: SyncStatusIndicator)
Widget syncStatusInteractive(BuildContext context) {
  final state = context.knobs.object.dropdown(
    label: 'Sync State',
    options: SyncState.values,
    labelBuilder: (s) => s.name,
    initialOption: SyncState.synced,
  );

  return Center(
    child: SyncStatusIndicator(state: state),
  );
}
