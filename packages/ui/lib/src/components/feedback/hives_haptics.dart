import 'package:flutter/services.dart';

/// Branded haptic feedback utility for the Hives app.
///
/// Wraps Flutter's [HapticFeedback] with named methods matching
/// the three feedback intensities used in the Hives design system.
/// Falls back silently on devices that do not support haptics.
///
/// Usage:
/// ```dart
/// // On button press:
/// await HivesHaptics.lightImpact();
///
/// // On save confirmation:
/// await HivesHaptics.mediumImpact();
///
/// // On urgent action:
/// await HivesHaptics.heavyImpact();
/// ```
abstract final class HivesHaptics {
  /// Light impact — use on standard button presses and chip selections.
  static Future<void> lightImpact() => HapticFeedback.lightImpact();

  /// Medium impact — use on save confirmations and successful actions.
  static Future<void> mediumImpact() => HapticFeedback.mediumImpact();

  /// Heavy impact — use on urgent alerts and destructive confirmations.
  static Future<void> heavyImpact() => HapticFeedback.heavyImpact();
}
