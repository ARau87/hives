import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';

/// A horizontal divider with a centered text label.
///
/// Renders two hairline rules flanking a centered label, commonly used
/// as an "or" separator between authentication options.
class HivesDividerWithLabel extends StatelessWidget {
  const HivesDividerWithLabel({super.key, required this.label});

  /// The text label displayed between the two divider lines.
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.colorScheme.outlineVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Row(
        children: [
          Expanded(child: Divider(height: 1, thickness: 1, color: dividerColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              label,
              style: AppTypography.label.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Divider(height: 1, thickness: 1, color: dividerColor)),
        ],
      ),
    );
  }
}
