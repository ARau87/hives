import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// A themed list tile following the Hives design system.
///
/// Wraps Flutter [ListTile] with consistent padding and design token usage.
/// Use [showDivider] for items in a list to add a bottom separator.
class HivesListTile extends StatelessWidget {
  /// The primary content of the list tile.
  final Widget title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display before the title.
  final Widget? leading;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the user taps this tile.
  final VoidCallback? onTap;

  /// Whether this tile is enabled for interaction.
  final bool isEnabled;

  /// Whether to show a divider below the tile.
  final bool showDivider;

  const HivesListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isEnabled = true,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: isEnabled ? onTap : null,
      enabled: isEnabled,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
      ),
    );

    if (!showDivider) return tile;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [tile, const Divider(height: AppSpacing.dividerSpace)],
    );
  }
}
