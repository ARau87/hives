import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';

/// Extension class for custom color definitions in the Hives app.
///
/// Uses [AppColors] as the source of truth for all color values.
/// Access via [Theme.of(context).extension<HivesColors>()] or
/// the convenience extension [HivesColorsExtension] on [ThemeData].
class HivesColors extends ThemeExtension<HivesColors> {
  final Color honey; // Primary amber color
  final Color honeyLight;
  final Color honeyDark;

  final Color secondary; // Secondary purple color
  final Color secondaryLight;

  final Color nature; // Status healthy green
  final Color natureLightShade;
  final Color natureDarkShade;

  final Color orange; // Accent orange
  final Color orangeLight;
  final Color orangeDark;

  final Color surface;
  final Color surfaceVariant;
  final Color outline;
  final Color outlineVariant;

  // Status colors
  final Color healthyStatus;
  final Color healthyFill;
  final Color attentionStatus;
  final Color attentionFill;
  final Color urgentStatus;
  final Color urgentFill;
  final Color unknownStatus;
  final Color unknownFill;

  const HivesColors({
    required this.honey,
    required this.honeyLight,
    required this.honeyDark,
    required this.secondary,
    required this.secondaryLight,
    required this.nature,
    required this.natureLightShade,
    required this.natureDarkShade,
    required this.orange,
    required this.orangeLight,
    required this.orangeDark,
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.healthyStatus,
    required this.healthyFill,
    required this.attentionStatus,
    required this.attentionFill,
    required this.urgentStatus,
    required this.urgentFill,
    required this.unknownStatus,
    required this.unknownFill,
  });

  @override
  HivesColors copyWith({
    Color? honey,
    Color? honeyLight,
    Color? honeyDark,
    Color? secondary,
    Color? secondaryLight,
    Color? nature,
    Color? natureLightShade,
    Color? natureDarkShade,
    Color? orange,
    Color? orangeLight,
    Color? orangeDark,
    Color? surface,
    Color? surfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? healthyStatus,
    Color? healthyFill,
    Color? attentionStatus,
    Color? attentionFill,
    Color? urgentStatus,
    Color? urgentFill,
    Color? unknownStatus,
    Color? unknownFill,
  }) {
    return HivesColors(
      honey: honey ?? this.honey,
      honeyLight: honeyLight ?? this.honeyLight,
      honeyDark: honeyDark ?? this.honeyDark,
      secondary: secondary ?? this.secondary,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      nature: nature ?? this.nature,
      natureLightShade: natureLightShade ?? this.natureLightShade,
      natureDarkShade: natureDarkShade ?? this.natureDarkShade,
      orange: orange ?? this.orange,
      orangeLight: orangeLight ?? this.orangeLight,
      orangeDark: orangeDark ?? this.orangeDark,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      healthyStatus: healthyStatus ?? this.healthyStatus,
      healthyFill: healthyFill ?? this.healthyFill,
      attentionStatus: attentionStatus ?? this.attentionStatus,
      attentionFill: attentionFill ?? this.attentionFill,
      urgentStatus: urgentStatus ?? this.urgentStatus,
      urgentFill: urgentFill ?? this.urgentFill,
      unknownStatus: unknownStatus ?? this.unknownStatus,
      unknownFill: unknownFill ?? this.unknownFill,
    );
  }

  @override
  HivesColors lerp(HivesColors? other, double t) {
    if (other is! HivesColors) {
      return this;
    }
    return HivesColors(
      honey: Color.lerp(honey, other.honey, t) ?? honey,
      honeyLight: Color.lerp(honeyLight, other.honeyLight, t) ?? honeyLight,
      honeyDark: Color.lerp(honeyDark, other.honeyDark, t) ?? honeyDark,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      secondaryLight:
          Color.lerp(secondaryLight, other.secondaryLight, t) ?? secondaryLight,
      nature: Color.lerp(nature, other.nature, t) ?? nature,
      natureLightShade:
          Color.lerp(natureLightShade, other.natureLightShade, t) ??
          natureLightShade,
      natureDarkShade:
          Color.lerp(natureDarkShade, other.natureDarkShade, t) ??
          natureDarkShade,
      orange: Color.lerp(orange, other.orange, t) ?? orange,
      orangeLight: Color.lerp(orangeLight, other.orangeLight, t) ?? orangeLight,
      orangeDark: Color.lerp(orangeDark, other.orangeDark, t) ?? orangeDark,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceVariant:
          Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      outline: Color.lerp(outline, other.outline, t) ?? outline,
      outlineVariant:
          Color.lerp(outlineVariant, other.outlineVariant, t) ?? outlineVariant,
      healthyStatus:
          Color.lerp(healthyStatus, other.healthyStatus, t) ?? healthyStatus,
      healthyFill:
          Color.lerp(healthyFill, other.healthyFill, t) ?? healthyFill,
      attentionStatus:
          Color.lerp(attentionStatus, other.attentionStatus, t) ??
          attentionStatus,
      attentionFill:
          Color.lerp(attentionFill, other.attentionFill, t) ?? attentionFill,
      urgentStatus:
          Color.lerp(urgentStatus, other.urgentStatus, t) ?? urgentStatus,
      urgentFill: Color.lerp(urgentFill, other.urgentFill, t) ?? urgentFill,
      unknownStatus:
          Color.lerp(unknownStatus, other.unknownStatus, t) ?? unknownStatus,
      unknownFill:
          Color.lerp(unknownFill, other.unknownFill, t) ?? unknownFill,
    );
  }

  /// Light theme colors aligned to UX specification.
  static const HivesColors light = HivesColors(
    // Honey (Primary Amber) colors
    honey: AppColors.primary,
    honeyLight: AppColors.primaryLight,
    honeyDark: AppColors.primaryDark,
    // Secondary (Purple) colors
    secondary: AppColors.secondary,
    secondaryLight: AppColors.secondaryLight,
    // Nature (Healthy Green) colors
    nature: AppColors.healthyStatus,
    natureLightShade: AppColors.healthyFill,
    natureDarkShade: Color(0xFF16A34A),
    // Orange accent colors
    orange: AppColors.orange,
    orangeLight: AppColors.orangeLight,
    orangeDark: Color(0xFFEA580C),
    // Surface colors
    surface: AppColors.surface,
    surfaceVariant: Color(0xFFF5F5F4),
    outline: AppColors.outline,
    outlineVariant: Color(0xFFD6D3D1),
    // Status colors
    healthyStatus: AppColors.healthyStatus,
    healthyFill: AppColors.healthyFill,
    attentionStatus: AppColors.attentionStatus,
    attentionFill: AppColors.attentionFill,
    urgentStatus: AppColors.urgentStatus,
    urgentFill: AppColors.urgentFill,
    unknownStatus: AppColors.unknownStatus,
    unknownFill: AppColors.unknownFill,
  );

  /// Dark theme colors with appropriate dark-mode variants.
  static const HivesColors dark = HivesColors(
    // Honey (Primary Amber) colors — slightly lighter for dark mode
    honey: Color(0xFFFBBF24),
    honeyLight: Color(0xFF78350F),
    honeyDark: Color(0xFFF59E0B),
    // Secondary (Purple) colors — lighter for dark mode
    secondary: Color(0xFFA78BFA),
    secondaryLight: Color(0xFF4C1D95),
    // Nature (Healthy Green) colors
    nature: Color(0xFF4ADE80),
    natureLightShade: Color(0xFF14532D),
    natureDarkShade: Color(0xFF86EFAC),
    // Orange accent colors
    orange: Color(0xFFFB923C),
    orangeLight: Color(0xFF7C2D12),
    orangeDark: Color(0xFFFED7AA),
    // Surface colors
    surface: Color(0xFF1C1917),
    surfaceVariant: Color(0xFF292524),
    outline: Color(0xFF44403C),
    outlineVariant: Color(0xFF292524),
    // Status colors — slightly lighter/vibrant for dark mode
    healthyStatus: Color(0xFF4ADE80),
    healthyFill: Color(0xFF14532D),
    attentionStatus: Color(0xFFFBBF24),
    attentionFill: Color(0xFF78350F),
    urgentStatus: Color(0xFFF87171),
    urgentFill: Color(0xFF7F1D1D),
    unknownStatus: Color(0xFFCBD5E1),
    unknownFill: Color(0xFF1E293B),
  );
}

/// Extension method to easily access HivesColors from ThemeData.
extension HivesColorsExtension on ThemeData {
  HivesColors get hivesColors => extension<HivesColors>() ?? HivesColors.light;
}
