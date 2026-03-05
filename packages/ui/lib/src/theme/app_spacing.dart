import 'package:flutter/material.dart';

/// Static spacing and shape constants using the 4px base unit system.
///
/// Provides named spacing values and [BorderRadius] constants matching
/// the UX specification. These are compile-time constants (no [BuildContext] needed).
abstract final class AppSpacing {
  // Base spacing scale (4px grid)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // Semantic spacing aliases
  static const double cardPadding = 20.0;
  static const double sectionGap = 28.0;
  static const double screenMargin = 20.0;
  static const double touchTargetMin = 48.0;
  static const double buttonHeight = 54.0;
  static const double fabDiameter = 64.0;

  // Shape constants
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(14));
  static const BorderRadius modalTopRadius = BorderRadius.vertical(
    top: Radius.circular(28),
  );
  static const BorderRadius dragHandleRadius = BorderRadius.all(Radius.circular(2));

  // Drag handle dimensions (bottom sheet indicator bar)
  static const double dragHandleWidth = 40.0;
  static const double dragHandleHeight = 4.0;

  // Divider
  static const double dividerSpace = 1.0;
}
