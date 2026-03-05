import 'dart:ui';

import 'package:flutter/material.dart';

/// Theme tokens specifically for surface components like cards and containers.
///
/// Defines surface-specific design values including padding, border radius,
/// elevation, and shadow properties for consistent card and surface styling.
class SurfaceThemeTokens extends ThemeExtension<SurfaceThemeTokens> {
  /// Padding for card content.
  final double cardPadding;

  /// Border radius for card shape.
  final double cardBorderRadius;

  /// Elevation level for cards in normal state.
  final double cardElevation;

  /// Elevation level for cards in hovered state.
  final double cardElevationHovered;

  /// Shadow blur radius for cards.
  final double shadowBlurRadius;

  /// Shadow spread radius for cards.
  final double shadowSpreadRadius;

  /// Shadow opacity for cards.
  final double shadowOpacity;

  /// Duration of elevation/shadow animations.
  final Duration animationDuration;

  const SurfaceThemeTokens({
    required this.cardPadding,
    required this.cardBorderRadius,
    required this.cardElevation,
    required this.cardElevationHovered,
    required this.shadowBlurRadius,
    required this.shadowSpreadRadius,
    required this.shadowOpacity,
    required this.animationDuration,
  });

  /// Creates standard surface theme tokens.
  factory SurfaceThemeTokens.standard() {
    return const SurfaceThemeTokens(
      cardPadding: 16.0,
      cardBorderRadius: 24.0,
      cardElevation: 2.0,
      cardElevationHovered: 8.0,
      shadowBlurRadius: 8.0,
      shadowSpreadRadius: 0.0,
      shadowOpacity: 0.15,
      animationDuration: Duration(milliseconds: 200),
    );
  }

  @override
  SurfaceThemeTokens copyWith({
    double? cardPadding,
    double? cardBorderRadius,
    double? cardElevation,
    double? cardElevationHovered,
    double? shadowBlurRadius,
    double? shadowSpreadRadius,
    double? shadowOpacity,
    Duration? animationDuration,
  }) {
    return SurfaceThemeTokens(
      cardPadding: cardPadding ?? this.cardPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      cardElevation: cardElevation ?? this.cardElevation,
      cardElevationHovered: cardElevationHovered ?? this.cardElevationHovered,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowSpreadRadius: shadowSpreadRadius ?? this.shadowSpreadRadius,
      shadowOpacity: shadowOpacity ?? this.shadowOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  SurfaceThemeTokens lerp(SurfaceThemeTokens? other, double t) {
    if (other is! SurfaceThemeTokens) {
      return this;
    }
    return SurfaceThemeTokens(
      cardPadding: lerpDouble(cardPadding, other.cardPadding, t) ?? cardPadding,
      cardBorderRadius:
          lerpDouble(cardBorderRadius, other.cardBorderRadius, t) ??
          cardBorderRadius,
      cardElevation:
          lerpDouble(cardElevation, other.cardElevation, t) ?? cardElevation,
      cardElevationHovered:
          lerpDouble(cardElevationHovered, other.cardElevationHovered, t) ??
          cardElevationHovered,
      shadowBlurRadius:
          lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t) ??
          shadowBlurRadius,
      shadowSpreadRadius:
          lerpDouble(shadowSpreadRadius, other.shadowSpreadRadius, t) ??
          shadowSpreadRadius,
      shadowOpacity:
          lerpDouble(shadowOpacity, other.shadowOpacity, t) ?? shadowOpacity,
      animationDuration: animationDuration,
    );
  }
}
