import 'dart:ui';

import 'package:flutter/material.dart';

/// Theme tokens specifically for input components.
///
/// Defines input-specific design values including padding, border radius,
/// and focus states for consistent text field and form input styling.
class InputThemeTokens extends ThemeExtension<InputThemeTokens> {
  /// Horizontal padding inside input field.
  final double paddingHorizontal;

  /// Vertical padding inside input field.
  final double paddingVertical;

  /// Border radius for input field shape.
  final double borderRadius;

  /// Border width in default state.
  final double borderWidth;

  /// Border width in focused state.
  final double focusedBorderWidth;

  /// Min height of input field.
  final double minHeight;

  /// Opacity value when input is disabled.
  final double disabledOpacity;

  /// Duration of focus/blur animations.
  final Duration animationDuration;

  const InputThemeTokens({
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.borderRadius,
    required this.borderWidth,
    required this.focusedBorderWidth,
    required this.minHeight,
    required this.disabledOpacity,
    required this.animationDuration,
  });

  /// Creates standard input theme tokens.
  factory InputThemeTokens.standard() {
    return const InputThemeTokens(
      paddingHorizontal: 16.0,
      paddingVertical: 12.0,
      borderRadius: 8.0,
      borderWidth: 1.0,
      focusedBorderWidth: 2.0,
      minHeight: 48.0,
      disabledOpacity: 0.5,
      animationDuration: Duration(milliseconds: 200),
    );
  }

  @override
  InputThemeTokens copyWith({
    double? paddingHorizontal,
    double? paddingVertical,
    double? borderRadius,
    double? borderWidth,
    double? focusedBorderWidth,
    double? minHeight,
    double? disabledOpacity,
    Duration? animationDuration,
  }) {
    return InputThemeTokens(
      paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
      paddingVertical: paddingVertical ?? this.paddingVertical,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      minHeight: minHeight ?? this.minHeight,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  InputThemeTokens lerp(InputThemeTokens? other, double t) {
    if (other is! InputThemeTokens) {
      return this;
    }
    return InputThemeTokens(
      paddingHorizontal:
          lerpDouble(paddingHorizontal, other.paddingHorizontal, t) ??
          paddingHorizontal,
      paddingVertical:
          lerpDouble(paddingVertical, other.paddingVertical, t) ??
          paddingVertical,
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      focusedBorderWidth:
          lerpDouble(focusedBorderWidth, other.focusedBorderWidth, t) ??
          focusedBorderWidth,
      minHeight: lerpDouble(minHeight, other.minHeight, t) ?? minHeight,
      disabledOpacity:
          lerpDouble(disabledOpacity, other.disabledOpacity, t) ??
          disabledOpacity,
      animationDuration: animationDuration,
    );
  }
}
