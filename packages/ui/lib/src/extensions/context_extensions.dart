import 'package:flutter/material.dart';
import 'package:ui/src/theme/hives_colors.dart';
import 'package:ui/src/theme/hives_spacings.dart';

/// Convenience [BuildContext] extension getters for accessing theme tokens.
extension HivesContextExtension on BuildContext {
  /// Access [HivesColors] ThemeExtension for custom brand and status colors.
  HivesColors get colors => Theme.of(this).hivesColors;

  /// Alias for [colors] — same as [HivesColors] ThemeExtension.
  /// Prefer [colors] for new code; both return the same value.
  HivesColors get appColors => Theme.of(this).hivesColors;

  /// Access [HivesSpacings] ThemeExtension for spacing values and EdgeInsets.
  HivesSpacings get spacings => Theme.of(this).spacings;

  /// Access the Material [ColorScheme] from the current theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access the [TextTheme] from the current theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access the full [ThemeData] for the current theme.
  ThemeData get theme => Theme.of(this);
}
