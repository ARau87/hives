import 'package:flutter/material.dart';

import '../../theme/surface_theme.dart';

/// A Material Design card component with customizable elevation and styling.
///
/// [HivesCard] displays content in a contained, elevated surface following
/// the Hives theme design tokens. It supports custom padding, border radius,
/// and elevation levels.
///
/// Example:
/// ```dart
/// HivesCard(
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Card content'),
///   ),
/// )
/// ```
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
    Key? key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.onTap,
    this.isClickable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceTokens = theme.extension<SurfaceThemeTokens>();

    final finalBorderRadius =
        borderRadius ??
        BorderRadius.circular(surfaceTokens?.cardBorderRadius ?? 12.0);
    final finalPadding =
        padding ?? EdgeInsets.all(surfaceTokens?.cardPadding ?? 16.0);
    final finalElevation = elevation ?? surfaceTokens?.cardElevation ?? 2.0;
    final finalBackgroundColor = backgroundColor ?? theme.colorScheme.surface;

    final card = Card(
      elevation: finalElevation,
      shape: RoundedRectangleBorder(borderRadius: finalBorderRadius),
      color: finalBackgroundColor,
      child: Padding(padding: finalPadding, child: child),
    );

    if (isClickable && onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: finalBorderRadius,
            child: card,
          ),
        ),
      );
    }

    return card;
  }
}
