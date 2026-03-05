import 'package:flutter/material.dart';

/// Static color constants matching the UX specification.
///
/// Serves as the single source of truth for all color values.
/// These are raw [Color] constants that do not require a [BuildContext].
/// Use [HivesColors] ThemeExtension for theme-aware access in widgets.
abstract final class AppColors {
  // Brand palette
  static const Color primary = Color(0xFFF59E0A);
  static const Color primaryDark = Color(0xFFD97706);
  static const Color primaryLight = Color(0xFFFEF3C7);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color secondaryLight = Color(0xFFEDE9FE);
  static const Color background = Color(0xFFFAFAF8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1917);
  static const Color onSurfaceVariant = Color(0xFFA8A29E);
  static const Color outline = Color(0xFFE7E5E4);

  // Status colors
  static const Color healthyStatus = Color(0xFF22C55E);
  static const Color healthyFill = Color(0xFFDCFCE7);
  static const Color attentionStatus = Color(0xFFF59E0B);
  static const Color attentionFill = Color(0xFFFEF3C7);
  static const Color urgentStatus = Color(0xFFEF4444);
  static const Color urgentFill = Color(0xFFFEE2E2);
  static const Color unknownStatus = Color(0xFF94A3B8);
  static const Color unknownFill = Color(0xFFF1F5F9);

  // Accent palette
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealLight = Color(0xFFCCFBF1);
  static const Color blue = Color(0xFF3B82F6);
  static const Color blueLight = Color(0xFFDBEAFE);
  static const Color orange = Color(0xFFF97316);
  static const Color orangeLight = Color(0xFFFED7AA);
}
