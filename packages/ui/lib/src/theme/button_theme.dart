import 'dart:ui';

import 'package:flutter/material.dart';

/// Theme tokens specifically for button components.
///
/// Defines button-specific design values including padding, min sizes,
/// state-based opacity values, shadow properties, animations, and spacing
/// for consistent button styling across the Hives app.
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

  /// Highlight color opacity for interactive elements.
  final double highlightOpacity;

  /// Duration of button animation effects.
  final Duration animationDuration;

  /// Shadow blur radius for button shadows.
  final double shadowBlurRadius;

  /// Shadow offset for button shadows.
  final Offset shadowOffset;

  /// Shadow opacity for button effects.
  final double shadowOpacity;

  /// Starting scale value for button tap animation.
  final double scaleStart;

  /// Ending scale value for button tap animation.
  final double scaleEnd;

  /// Size of loading indicator in buttons.
  final double loadingIndicatorSize;

  /// Stroke width for loading indicators.
  final double loadingStrokeWidth;

  /// Spacing between icon and text in buttons.
  final double iconTextSpacing;

  const ButtonThemeTokens({
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.minWidth,
    required this.minHeight,
    required this.borderRadius,
    required this.disabledOpacity,
    required this.splashOpacity,
    required this.highlightOpacity,
    required this.animationDuration,
    required this.shadowBlurRadius,
    required this.shadowOffset,
    required this.shadowOpacity,
    required this.scaleStart,
    required this.scaleEnd,
    required this.loadingIndicatorSize,
    required this.loadingStrokeWidth,
    required this.iconTextSpacing,
  });

  /// Creates standard button theme tokens.
  factory ButtonThemeTokens.standard() {
    return const ButtonThemeTokens(
      paddingHorizontal: 24.0,
      paddingVertical: 12.0,
      minWidth: 120.0,
      minHeight: 54.0,
      borderRadius: 16.0,
      disabledOpacity: 0.5,
      splashOpacity: 0.2,
      highlightOpacity: 0.1,
      animationDuration: Duration(milliseconds: 200),
      shadowBlurRadius: 8.0,
      shadowOffset: Offset(0, 4),
      shadowOpacity: 0.3,
      scaleStart: 1.0,
      scaleEnd: 0.95,
      loadingIndicatorSize: 20.0,
      loadingStrokeWidth: 2.0,
      iconTextSpacing: 8.0,
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
    double? highlightOpacity,
    Duration? animationDuration,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    double? shadowOpacity,
    double? scaleStart,
    double? scaleEnd,
    double? loadingIndicatorSize,
    double? loadingStrokeWidth,
    double? iconTextSpacing,
  }) {
    return ButtonThemeTokens(
      paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
      paddingVertical: paddingVertical ?? this.paddingVertical,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      splashOpacity: splashOpacity ?? this.splashOpacity,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
      scaleStart: scaleStart ?? this.scaleStart,
      scaleEnd: scaleEnd ?? this.scaleEnd,
      loadingIndicatorSize: loadingIndicatorSize ?? this.loadingIndicatorSize,
      loadingStrokeWidth: loadingStrokeWidth ?? this.loadingStrokeWidth,
      iconTextSpacing: iconTextSpacing ?? this.iconTextSpacing,
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
      highlightOpacity:
          lerpDouble(highlightOpacity, other.highlightOpacity, t) ??
          highlightOpacity,
      shadowBlurRadius:
          lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t) ??
          shadowBlurRadius,
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
      shadowOpacity:
          lerpDouble(shadowOpacity, other.shadowOpacity, t) ?? shadowOpacity,
      scaleStart: lerpDouble(scaleStart, other.scaleStart, t) ?? scaleStart,
      scaleEnd: lerpDouble(scaleEnd, other.scaleEnd, t) ?? scaleEnd,
      loadingIndicatorSize:
          lerpDouble(loadingIndicatorSize, other.loadingIndicatorSize, t) ??
          loadingIndicatorSize,
      loadingStrokeWidth:
          lerpDouble(loadingStrokeWidth, other.loadingStrokeWidth, t) ??
          loadingStrokeWidth,
      iconTextSpacing:
          lerpDouble(iconTextSpacing, other.iconTextSpacing, t) ??
          iconTextSpacing,
      animationDuration: animationDuration,
    );
  }
}
