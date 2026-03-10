import 'package:flutter/material.dart';
import 'package:ui/src/components/feedback/status_badge.dart';
import 'package:ui/src/theme/app_colors.dart';

/// Health status variants for hive card components.
///
/// Each variant maps to a fill background color (for [HiveCardTile]),
/// an accent color (for left bars on [HiveCardSimple] and [HiveCardCompact]),
/// and a [HivesStatusVariant] for [StatusBadge] integration.
enum HivesHiveStatus {
  /// Hive is healthy.
  healthy,

  /// Hive needs attention.
  attention,

  /// Hive needs urgent care.
  urgent,

  /// Hive status is unknown.
  unknown;

  /// Fill background color for tile cards.
  Color get fillColor => switch (this) {
    HivesHiveStatus.healthy => AppColors.healthyFill,
    HivesHiveStatus.attention => AppColors.attentionFill,
    HivesHiveStatus.urgent => AppColors.urgentFill,
    HivesHiveStatus.unknown => AppColors.unknownFill,
  };

  /// Accent color for left status bars.
  Color get accentColor => switch (this) {
    HivesHiveStatus.healthy => AppColors.healthyStatus,
    HivesHiveStatus.attention => AppColors.attentionStatus,
    HivesHiveStatus.urgent => AppColors.urgentStatus,
    HivesHiveStatus.unknown => AppColors.unknownStatus,
  };

  /// Maps to [HivesStatusVariant] for [StatusBadge] rendering.
  HivesStatusVariant get badgeVariant => switch (this) {
    HivesHiveStatus.healthy => HivesStatusVariant.healthy,
    HivesHiveStatus.attention => HivesStatusVariant.attention,
    HivesHiveStatus.urgent => HivesStatusVariant.urgent,
    HivesHiveStatus.unknown => HivesStatusVariant.unknown,
  };
}
