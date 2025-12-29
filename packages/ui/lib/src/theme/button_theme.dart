import 'dart:ui';

import 'package:flutter/material.dart';

/// Theme tokens specifically for button components.
///
/// Defines button-specific design values including padding, min sizes,
/// and state-based opacity values for consistent button styling across
/// the Hives app.
class ButtonThemeTokens extends ThemeExtension<ButtonThemeTokens> {
  /// Horizontal padding for button content.
  final double paddingHorizontal;

  /// Vertical padding for button content.
  final double paddingVertical;

  /// Minimum button width.
  final double minWidth;

  /// Minimum button height.
  final double minHeight;

  /// Border radius for button shape.
  final double borderRadius;

  /// Opacity value when button is disabled.
  final double disabledOpacity;

  /// Opacity value for splash effect on interaction.
  final double splashOpacity;

  /// Duration of button animation effects.
  final Duration animationDuration;

  const ButtonThemeTokens({
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.minWidth,
    required this.minHeight,
    required this.borderRadius,
    required this.disabledOpacity,
    required this.splashOpacity,
    required this.animationDuration,
  });

  /// Creates standard button theme tokens.
  factory ButtonThemeTokens.standard() {
    return const ButtonThemeTokens(
      paddingHorizontal: 24.0,
      paddingVertical: 12.0,
      minWidth: 120.0,
      minHeight: 48.0,
      borderRadius: 12.0,
      disabledOpacity: 0.5,
      splashOpacity: 0.2,
      animationDuration: Duration(milliseconds: 200),
    );
  }

  @override
  ButtonThemeTokens copyWith({
    double? paddingHorizontal,
    double? paddingVertical,
    double? minWidth,
    double? minHeight,
    double? borderRadius,
    double? disabledOpacity,
    double? splashOpacity,
    Duration? animationDuration,
  }) {
    return ButtonThemeTokens(
      paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
      paddingVertical: paddingVertical ?? this.paddingVertical,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      splashOpacity: splashOpacity ?? this.splashOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  ButtonThemeTokens lerp(ButtonThemeTokens? other, double t) {
    if (other is! ButtonThemeTokens) {
      return this;
    }
    return ButtonThemeTokens(
      paddingHorizontal:
          lerpDouble(paddingHorizontal, other.paddingHorizontal, t) ??
          paddingHorizontal,
      paddingVertical:
          lerpDouble(paddingVertical, other.paddingVertical, t) ??
          paddingVertical,
      minWidth: lerpDouble(minWidth, other.minWidth, t) ?? minWidth,
      minHeight: lerpDouble(minHeight, other.minHeight, t) ?? minHeight,
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      disabledOpacity:
          lerpDouble(disabledOpacity, other.disabledOpacity, t) ??
          disabledOpacity,
      splashOpacity:
          lerpDouble(splashOpacity, other.splashOpacity, t) ?? splashOpacity,
      animationDuration: animationDuration,
    );
  }
}
