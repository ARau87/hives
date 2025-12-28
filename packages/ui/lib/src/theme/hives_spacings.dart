import 'dart:ui';

import 'package:flutter/material.dart';

/// Extension class for consistent spacing values throughout the Hives app
class HivesSpacings extends ThemeExtension<HivesSpacings> {
  // Minimal spacings
  final double xs; // 4px - minimal spacing
  final double sm; // 8px - small spacing
  final double md; // 12px - medium spacing
  final double lg; // 16px - large spacing
  final double xl; // 20px - extra large spacing
  final double xxl; // 24px - extra extra large spacing
  final double xxxl; // 32px - massive spacing

  // Common EdgeInsets combinations
  final EdgeInsets paddingXs;
  final EdgeInsets paddingSm;
  final EdgeInsets paddingMd;
  final EdgeInsets paddingLg;
  final EdgeInsets paddingXl;
  final EdgeInsets paddingXxl;
  final EdgeInsets paddingXxxl;

  // Directional padding
  final EdgeInsets paddingHorizontalSm;
  final EdgeInsets paddingHorizontalMd;
  final EdgeInsets paddingHorizontalLg;
  final EdgeInsets paddingVerticalSm;
  final EdgeInsets paddingVerticalMd;
  final EdgeInsets paddingVerticalLg;

  // Common margin values (same as spacing values)
  final EdgeInsets marginXs;
  final EdgeInsets marginSm;
  final EdgeInsets marginMd;
  final EdgeInsets marginLg;
  final EdgeInsets marginXl;
  final EdgeInsets marginXxl;
  final EdgeInsets marginXxxl;

  // Directional margins
  final EdgeInsets marginHorizontalSm;
  final EdgeInsets marginHorizontalMd;
  final EdgeInsets marginHorizontalLg;
  final EdgeInsets marginVerticalSm;
  final EdgeInsets marginVerticalMd;
  final EdgeInsets marginVerticalLg;

  // Safe area insets for common container padding
  final EdgeInsets containerPadding;
  final EdgeInsets screenPadding;

  const HivesSpacings({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.paddingXs,
    required this.paddingSm,
    required this.paddingMd,
    required this.paddingLg,
    required this.paddingXl,
    required this.paddingXxl,
    required this.paddingXxxl,
    required this.paddingHorizontalSm,
    required this.paddingHorizontalMd,
    required this.paddingHorizontalLg,
    required this.paddingVerticalSm,
    required this.paddingVerticalMd,
    required this.paddingVerticalLg,
    required this.marginXs,
    required this.marginSm,
    required this.marginMd,
    required this.marginLg,
    required this.marginXl,
    required this.marginXxl,
    required this.marginXxxl,
    required this.marginHorizontalSm,
    required this.marginHorizontalMd,
    required this.marginHorizontalLg,
    required this.marginVerticalSm,
    required this.marginVerticalMd,
    required this.marginVerticalLg,
    required this.containerPadding,
    required this.screenPadding,
  });

  @override
  HivesSpacings copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    EdgeInsets? paddingXs,
    EdgeInsets? paddingSm,
    EdgeInsets? paddingMd,
    EdgeInsets? paddingLg,
    EdgeInsets? paddingXl,
    EdgeInsets? paddingXxl,
    EdgeInsets? paddingXxxl,
    EdgeInsets? paddingHorizontalSm,
    EdgeInsets? paddingHorizontalMd,
    EdgeInsets? paddingHorizontalLg,
    EdgeInsets? paddingVerticalSm,
    EdgeInsets? paddingVerticalMd,
    EdgeInsets? paddingVerticalLg,
    EdgeInsets? marginXs,
    EdgeInsets? marginSm,
    EdgeInsets? marginMd,
    EdgeInsets? marginLg,
    EdgeInsets? marginXl,
    EdgeInsets? marginXxl,
    EdgeInsets? marginXxxl,
    EdgeInsets? marginHorizontalSm,
    EdgeInsets? marginHorizontalMd,
    EdgeInsets? marginHorizontalLg,
    EdgeInsets? marginVerticalSm,
    EdgeInsets? marginVerticalMd,
    EdgeInsets? marginVerticalLg,
    EdgeInsets? containerPadding,
    EdgeInsets? screenPadding,
  }) {
    return HivesSpacings(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      paddingXs: paddingXs ?? this.paddingXs,
      paddingSm: paddingSm ?? this.paddingSm,
      paddingMd: paddingMd ?? this.paddingMd,
      paddingLg: paddingLg ?? this.paddingLg,
      paddingXl: paddingXl ?? this.paddingXl,
      paddingXxl: paddingXxl ?? this.paddingXxl,
      paddingXxxl: paddingXxxl ?? this.paddingXxxl,
      paddingHorizontalSm: paddingHorizontalSm ?? this.paddingHorizontalSm,
      paddingHorizontalMd: paddingHorizontalMd ?? this.paddingHorizontalMd,
      paddingHorizontalLg: paddingHorizontalLg ?? this.paddingHorizontalLg,
      paddingVerticalSm: paddingVerticalSm ?? this.paddingVerticalSm,
      paddingVerticalMd: paddingVerticalMd ?? this.paddingVerticalMd,
      paddingVerticalLg: paddingVerticalLg ?? this.paddingVerticalLg,
      marginXs: marginXs ?? this.marginXs,
      marginSm: marginSm ?? this.marginSm,
      marginMd: marginMd ?? this.marginMd,
      marginLg: marginLg ?? this.marginLg,
      marginXl: marginXl ?? this.marginXl,
      marginXxl: marginXxl ?? this.marginXxl,
      marginXxxl: marginXxxl ?? this.marginXxxl,
      marginHorizontalSm: marginHorizontalSm ?? this.marginHorizontalSm,
      marginHorizontalMd: marginHorizontalMd ?? this.marginHorizontalMd,
      marginHorizontalLg: marginHorizontalLg ?? this.marginHorizontalLg,
      marginVerticalSm: marginVerticalSm ?? this.marginVerticalSm,
      marginVerticalMd: marginVerticalMd ?? this.marginVerticalMd,
      marginVerticalLg: marginVerticalLg ?? this.marginVerticalLg,
      containerPadding: containerPadding ?? this.containerPadding,
      screenPadding: screenPadding ?? this.screenPadding,
    );
  }

  @override
  HivesSpacings lerp(HivesSpacings? other, double t) {
    if (other is! HivesSpacings) {
      return this;
    }
    return HivesSpacings(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
      xxl: lerpDouble(xxl, other.xxl, t) ?? xxl,
      xxxl: lerpDouble(xxxl, other.xxxl, t) ?? xxxl,
      paddingXs: EdgeInsets.lerp(paddingXs, other.paddingXs, t) ?? paddingXs,
      paddingSm: EdgeInsets.lerp(paddingSm, other.paddingSm, t) ?? paddingSm,
      paddingMd: EdgeInsets.lerp(paddingMd, other.paddingMd, t) ?? paddingMd,
      paddingLg: EdgeInsets.lerp(paddingLg, other.paddingLg, t) ?? paddingLg,
      paddingXl: EdgeInsets.lerp(paddingXl, other.paddingXl, t) ?? paddingXl,
      paddingXxl:
          EdgeInsets.lerp(paddingXxl, other.paddingXxl, t) ?? paddingXxl,
      paddingXxxl:
          EdgeInsets.lerp(paddingXxxl, other.paddingXxxl, t) ?? paddingXxxl,
      paddingHorizontalSm:
          EdgeInsets.lerp(paddingHorizontalSm, other.paddingHorizontalSm, t) ??
          paddingHorizontalSm,
      paddingHorizontalMd:
          EdgeInsets.lerp(paddingHorizontalMd, other.paddingHorizontalMd, t) ??
          paddingHorizontalMd,
      paddingHorizontalLg:
          EdgeInsets.lerp(paddingHorizontalLg, other.paddingHorizontalLg, t) ??
          paddingHorizontalLg,
      paddingVerticalSm:
          EdgeInsets.lerp(paddingVerticalSm, other.paddingVerticalSm, t) ??
          paddingVerticalSm,
      paddingVerticalMd:
          EdgeInsets.lerp(paddingVerticalMd, other.paddingVerticalMd, t) ??
          paddingVerticalMd,
      paddingVerticalLg:
          EdgeInsets.lerp(paddingVerticalLg, other.paddingVerticalLg, t) ??
          paddingVerticalLg,
      marginXs: EdgeInsets.lerp(marginXs, other.marginXs, t) ?? marginXs,
      marginSm: EdgeInsets.lerp(marginSm, other.marginSm, t) ?? marginSm,
      marginMd: EdgeInsets.lerp(marginMd, other.marginMd, t) ?? marginMd,
      marginLg: EdgeInsets.lerp(marginLg, other.marginLg, t) ?? marginLg,
      marginXl: EdgeInsets.lerp(marginXl, other.marginXl, t) ?? marginXl,
      marginXxl: EdgeInsets.lerp(marginXxl, other.marginXxl, t) ?? marginXxl,
      marginXxxl:
          EdgeInsets.lerp(marginXxxl, other.marginXxxl, t) ?? marginXxxl,
      marginHorizontalSm:
          EdgeInsets.lerp(marginHorizontalSm, other.marginHorizontalSm, t) ??
          marginHorizontalSm,
      marginHorizontalMd:
          EdgeInsets.lerp(marginHorizontalMd, other.marginHorizontalMd, t) ??
          marginHorizontalMd,
      marginHorizontalLg:
          EdgeInsets.lerp(marginHorizontalLg, other.marginHorizontalLg, t) ??
          marginHorizontalLg,
      marginVerticalSm:
          EdgeInsets.lerp(marginVerticalSm, other.marginVerticalSm, t) ??
          marginVerticalSm,
      marginVerticalMd:
          EdgeInsets.lerp(marginVerticalMd, other.marginVerticalMd, t) ??
          marginVerticalMd,
      marginVerticalLg:
          EdgeInsets.lerp(marginVerticalLg, other.marginVerticalLg, t) ??
          marginVerticalLg,
      containerPadding:
          EdgeInsets.lerp(containerPadding, other.containerPadding, t) ??
          containerPadding,
      screenPadding:
          EdgeInsets.lerp(screenPadding, other.screenPadding, t) ??
          screenPadding,
    );
  }

  /// Standard spacings for the Hives app
  /// All values are the same for light and dark themes
  static const HivesSpacings standard = HivesSpacings(
    // Base spacing values
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 20.0,
    xxl: 24.0,
    xxxl: 32.0,
    // Padding combinations (all sides)
    paddingXs: EdgeInsets.all(4.0),
    paddingSm: EdgeInsets.all(8.0),
    paddingMd: EdgeInsets.all(12.0),
    paddingLg: EdgeInsets.all(16.0),
    paddingXl: EdgeInsets.all(20.0),
    paddingXxl: EdgeInsets.all(24.0),
    paddingXxxl: EdgeInsets.all(32.0),
    // Horizontal padding
    paddingHorizontalSm: EdgeInsets.symmetric(horizontal: 8.0),
    paddingHorizontalMd: EdgeInsets.symmetric(horizontal: 12.0),
    paddingHorizontalLg: EdgeInsets.symmetric(horizontal: 16.0),
    // Vertical padding
    paddingVerticalSm: EdgeInsets.symmetric(vertical: 8.0),
    paddingVerticalMd: EdgeInsets.symmetric(vertical: 12.0),
    paddingVerticalLg: EdgeInsets.symmetric(vertical: 16.0),
    // Margin combinations (all sides)
    marginXs: EdgeInsets.all(4.0),
    marginSm: EdgeInsets.all(8.0),
    marginMd: EdgeInsets.all(12.0),
    marginLg: EdgeInsets.all(16.0),
    marginXl: EdgeInsets.all(20.0),
    marginXxl: EdgeInsets.all(24.0),
    marginXxxl: EdgeInsets.all(32.0),
    // Horizontal margins
    marginHorizontalSm: EdgeInsets.symmetric(horizontal: 8.0),
    marginHorizontalMd: EdgeInsets.symmetric(horizontal: 12.0),
    marginHorizontalLg: EdgeInsets.symmetric(horizontal: 16.0),
    // Vertical margins
    marginVerticalSm: EdgeInsets.symmetric(vertical: 8.0),
    marginVerticalMd: EdgeInsets.symmetric(vertical: 12.0),
    marginVerticalLg: EdgeInsets.symmetric(vertical: 16.0),
    // Common container/screen padding
    containerPadding: EdgeInsets.all(16.0),
    screenPadding: EdgeInsets.all(16.0),
  );
}

/// Extension method to easily access HivesSpacings from ThemeData
extension HivesSpacingsExtension on ThemeData {
  HivesSpacings get spacings =>
      extension<HivesSpacings>() ?? HivesSpacings.standard;
}
