import 'package:flutter/material.dart';
import 'package:ui/src/theme/surface_theme.dart';

/// A Material Design card component with customizable elevation and styling.
///
/// [HivesCard] uses [Card] and relies on [CardTheme] for visuals; only
/// provides minimal overrides and optional click handling.
class HivesCard extends StatelessWidget {
  /// The content widget displayed inside the card.
  final Widget child;

  /// Custom padding inside the card.
  final EdgeInsets? padding;

  /// Custom border radius for the card shape.
  final BorderRadius? borderRadius;

  /// Elevation level of the card.
  final double? elevation;

  /// Background color of the card.
  final Color? backgroundColor;

  /// Callback invoked when the card is tapped (optional).
  final VoidCallback? onTap;

  /// Whether the card should respond to taps.
  final bool isClickable;

  const HivesCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.onTap,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceTokens = theme.extension<SurfaceThemeTokens>();

    final resolvedRadius =
        borderRadius ??
        BorderRadius.circular(surfaceTokens?.cardBorderRadius ?? 12.0);
    final resolvedPadding =
        padding ?? EdgeInsets.all(surfaceTokens?.cardPadding ?? 16.0);

    final card = Card(
      elevation: elevation ?? surfaceTokens?.cardElevation,
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: resolvedRadius),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: resolvedPadding, child: child),
    );

    if (isClickable && onTap != null) {
      return InkWell(onTap: onTap, borderRadius: resolvedRadius, child: card);
    }

    return card;
  }
}
