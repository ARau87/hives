import 'dart:ui';

import 'package:flutter/material.dart';

/// Extension class for component-specific design tokens in the Hives app.
///
/// Centralizes commonly reused values for buttons, cards, and other UI components
/// like border radius, shadow properties, opacity values, and animation durations.
class HivesComponentTheme extends ThemeExtension<HivesComponentTheme> {
  /// Border radius used for buttons and similar components.
  final double borderRadius;

  /// Shadow blur radius for component shadows.
  final double shadowBlurRadius;

  /// Shadow offset for component shadows.
  final Offset shadowOffset;

  /// Shadow opacity for disabled or subtle shadows.
  final double shadowOpacity;

  /// Splash color opacity for interactive elements.
  final double splashOpacity;

  /// Highlight color opacity for interactive elements.
  final double highlightOpacity;

  /// Opacity applied to disabled components.
  final double disabledOpacity;

  /// Default button height.
  final double buttonHeight;

  /// Starting scale value for button tap animation.
  final double buttonScaleStart;

  /// Ending scale value for button tap animation.
  final double buttonScaleEnd;

  /// Size of loading indicator in components.
  final double loadingIndicatorSize;

  /// Stroke width for loading indicators.
  final double loadingStrokeWidth;

  /// Spacing between icon and text in components.
  final double iconTextSpacing;

  /// Standard duration for component animations.
  final Duration animationDuration;

  const HivesComponentTheme({
    required this.borderRadius,
    required this.shadowBlurRadius,
    required this.shadowOffset,
    required this.shadowOpacity,
    required this.splashOpacity,
    required this.highlightOpacity,
    required this.disabledOpacity,
    required this.buttonHeight,
    required this.buttonScaleStart,
    required this.buttonScaleEnd,
    required this.loadingIndicatorSize,
    required this.loadingStrokeWidth,
    required this.iconTextSpacing,
    required this.animationDuration,
  });

  /// Creates a standard component theme configuration.
  factory HivesComponentTheme.standard() {
    return const HivesComponentTheme(
      borderRadius: 12.0,
      shadowBlurRadius: 8.0,
      shadowOffset: Offset(0, 4),
      shadowOpacity: 0.3,
      splashOpacity: 0.2,
      highlightOpacity: 0.1,
      disabledOpacity: 0.5,
      buttonHeight: 56.0,
      buttonScaleStart: 1.0,
      buttonScaleEnd: 0.95,
      loadingIndicatorSize: 20.0,
      loadingStrokeWidth: 2.0,
      iconTextSpacing: 8.0,
      animationDuration: Duration(milliseconds: 200),
    );
  }

  @override
  HivesComponentTheme copyWith({
    double? borderRadius,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    double? shadowOpacity,
    double? splashOpacity,
    double? highlightOpacity,
    double? disabledOpacity,
    double? buttonHeight,
    double? buttonScaleStart,
    double? buttonScaleEnd,
    double? loadingIndicatorSize,
    double? loadingStrokeWidth,
    double? iconTextSpacing,
    Duration? animationDuration,
  }) {
    return HivesComponentTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
      splashOpacity: splashOpacity ?? this.splashOpacity,
      highlightOpacity: highlightOpacity ?? this.highlightOpacity,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonScaleStart: buttonScaleStart ?? this.buttonScaleStart,
      buttonScaleEnd: buttonScaleEnd ?? this.buttonScaleEnd,
      loadingIndicatorSize: loadingIndicatorSize ?? this.loadingIndicatorSize,
      loadingStrokeWidth: loadingStrokeWidth ?? this.loadingStrokeWidth,
      iconTextSpacing: iconTextSpacing ?? this.iconTextSpacing,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  HivesComponentTheme lerp(HivesComponentTheme? other, double t) {
    if (other is! HivesComponentTheme) {
      return this;
    }
    return HivesComponentTheme(
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      shadowBlurRadius:
          lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t) ??
          shadowBlurRadius,
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
      shadowOpacity:
          lerpDouble(shadowOpacity, other.shadowOpacity, t) ?? shadowOpacity,
      splashOpacity:
          lerpDouble(splashOpacity, other.splashOpacity, t) ?? splashOpacity,
      highlightOpacity:
          lerpDouble(highlightOpacity, other.highlightOpacity, t) ??
          highlightOpacity,
      disabledOpacity:
          lerpDouble(disabledOpacity, other.disabledOpacity, t) ??
          disabledOpacity,
      buttonHeight:
          lerpDouble(buttonHeight, other.buttonHeight, t) ?? buttonHeight,
      buttonScaleStart:
          lerpDouble(buttonScaleStart, other.buttonScaleStart, t) ??
          buttonScaleStart,
      buttonScaleEnd:
          lerpDouble(buttonScaleEnd, other.buttonScaleEnd, t) ?? buttonScaleEnd,
      loadingIndicatorSize:
          lerpDouble(loadingIndicatorSize, other.loadingIndicatorSize, t) ??
          loadingIndicatorSize,
      loadingStrokeWidth:
          lerpDouble(loadingStrokeWidth, other.loadingStrokeWidth, t) ??
          loadingStrokeWidth,
      iconTextSpacing:
          lerpDouble(iconTextSpacing, other.iconTextSpacing, t) ??
          iconTextSpacing,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
    );
  }
}

/// Extension on [BuildContext] for convenient access to [HivesComponentTheme].
extension HivesComponentThemeX on BuildContext {
  /// Retrieves the current [HivesComponentTheme] from the theme.
  HivesComponentTheme get hivesComponentTheme =>
      Theme.of(this).extension<HivesComponentTheme>() ??
      HivesComponentTheme.standard();
}
