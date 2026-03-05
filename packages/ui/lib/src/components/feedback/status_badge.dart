import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';

/// Status variants for [StatusBadge].
///
/// Maps to the four hive health states in the Hives design system.
/// Each variant has a distinct color and icon for accessibility (not color-only).
enum HivesStatusVariant { healthy, attention, urgent, unknown }

/// A circular badge displaying a hive status with both color and icon.
///
/// Accessibility note: always uses color AND icon together — never color-only.
/// Uses [HivesColors] ThemeExtension for status fill and icon colors.
///
/// Example:
/// ```dart
/// StatusBadge(variant: HivesStatusVariant.healthy)
/// StatusBadge(variant: HivesStatusVariant.urgent, size: 32)
/// ```
class StatusBadge extends StatelessWidget {
  /// The health/status variant to display.
  final HivesStatusVariant variant;

  /// Diameter of the badge in logical pixels. Defaults to 24.
  final double size;

  const StatusBadge({
    super.key,
    required this.variant,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (fillColor, iconColor, icon, semanticLabel) = switch (variant) {
      HivesStatusVariant.healthy => (
        colors.healthyFill,
        colors.healthyStatus,
        Icons.check_circle,
        'Healthy status',
      ),
      HivesStatusVariant.attention => (
        colors.attentionFill,
        colors.attentionStatus,
        Icons.warning,
        'Needs attention',
      ),
      HivesStatusVariant.urgent => (
        colors.urgentFill,
        colors.urgentStatus,
        Icons.error,
        'Urgent',
      ),
      HivesStatusVariant.unknown => (
        colors.unknownFill,
        colors.unknownStatus,
        Icons.help_outline,
        'Unknown status',
      ),
    };

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size * 0.6,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
