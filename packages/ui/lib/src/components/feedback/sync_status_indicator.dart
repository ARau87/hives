import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Sync connection states for [SyncStatusIndicator].
enum SyncState { offline, syncing, synced, error }

/// A compact row widget displaying the current data sync state.
///
/// Shows an icon and a label for each of the four sync states.
/// Colors are sourced from [HivesColors] ThemeExtension.
///
/// Example:
/// ```dart
/// SyncStatusIndicator(state: SyncState.synced)
/// SyncStatusIndicator(state: SyncState.offline)
/// ```
class SyncStatusIndicator extends StatelessWidget {
  /// The current synchronization state.
  final SyncState state;

  const SyncStatusIndicator({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (icon, color, label) = switch (state) {
      SyncState.offline => (Icons.cloud_off, colors.unknownStatus, 'Offline'),
      SyncState.syncing => (Icons.sync, colors.honey, 'Syncing...'),
      SyncState.synced => (Icons.cloud_done, colors.healthyStatus, 'Synced'),
      SyncState.error => (Icons.sync_problem, colors.urgentStatus, 'Sync Error'),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
