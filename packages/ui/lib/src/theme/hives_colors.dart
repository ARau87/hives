import 'package:flutter/material.dart';

/// Extension class for custom color definitions in the Hives app
class HivesColors extends ThemeExtension<HivesColors> {
  final Color honey; // Primary amber color
  final Color honeyLight;
  final Color honeyDark;

  final Color hiveWood; // Secondary brown color
  final Color hiveWoodLight;
  final Color hiveWoodDark;

  final Color nature; // Tertiary green color
  final Color natureLightShade;
  final Color natureDarkShade;

  final Color orange; // Additional orange color for future use
  final Color orangeLight;
  final Color orangeDark;

  final Color surface;
  final Color surfaceVariant;
  final Color outline;
  final Color outlineVariant;

  const HivesColors({
    // Honey (Amber) colors
    required this.honey,
    required this.honeyLight,
    required this.honeyDark,
    // Hive Wood (Brown) colors
    required this.hiveWood,
    required this.hiveWoodLight,
    required this.hiveWoodDark,
    // Nature (Green) colors
    required this.nature,
    required this.natureLightShade,
    required this.natureDarkShade,
    // Orange colors
    required this.orange,
    required this.orangeLight,
    required this.orangeDark,
    // Surface colors
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
    required this.outlineVariant,
  });

  @override
  HivesColors copyWith({
    Color? honey,
    Color? honeyLight,
    Color? honeyDark,
    Color? hiveWood,
    Color? hiveWoodLight,
    Color? hiveWoodDark,
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
  }) {
    return HivesColors(
      honey: honey ?? this.honey,
      honeyLight: honeyLight ?? this.honeyLight,
      honeyDark: honeyDark ?? this.honeyDark,
      hiveWood: hiveWood ?? this.hiveWood,
      hiveWoodLight: hiveWoodLight ?? this.hiveWoodLight,
      hiveWoodDark: hiveWoodDark ?? this.hiveWoodDark,
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
      hiveWood: Color.lerp(hiveWood, other.hiveWood, t) ?? hiveWood,
      hiveWoodLight:
          Color.lerp(hiveWoodLight, other.hiveWoodLight, t) ?? hiveWoodLight,
      hiveWoodDark:
          Color.lerp(hiveWoodDark, other.hiveWoodDark, t) ?? hiveWoodDark,
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
    );
  }

  /// Light theme colors
  static const HivesColors light = HivesColors(
    // Honey colors
    honey: Color(0xFFFFC107),
    honeyLight: Color(0xFFFFECB3),
    honeyDark: Color(0xFFFFB300),
    // Hive wood colors
    hiveWood: Color(0xFF795548),
    hiveWoodLight: Color(0xFFA1887F),
    hiveWoodDark: Color(0xFF4E342E),
    // Nature colors
    nature: Color(0xFF8BC34A),
    natureLightShade: Color(0xFFC5E1A5),
    natureDarkShade: Color(0xFF558B2F),
    // Orange colors
    orange: Color(0xFFFF9800),
    orangeLight: Color(0xFFFFCC80),
    orangeDark: Color(0xFFF57C00),
    // Surface colors
    surface: Color(0xFFFFFBFF),
    surfaceVariant: Color(0xFFE6E1E5),
    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),
  );

  /// Dark theme colors
  static const HivesColors dark = HivesColors(
    // Honey colors
    honey: Color(0xFFFFD54F),
    honeyLight: Color(0xFFFFF59D),
    honeyDark: Color(0xFFFFA000),
    // Hive wood colors
    hiveWood: Color(0xFFBCAAA4),
    hiveWoodLight: Color(0xFFD7CCC8),
    hiveWoodDark: Color(0xFF795548),
    // Nature colors
    nature: Color(0xFFAED581),
    natureLightShade: Color(0xFFDCEDC8),
    natureDarkShade: Color(0xFF8BC34A),
    // Orange colors
    orange: Color(0xFFFFB74D),
    orangeLight: Color(0xFFFFE0B2),
    orangeDark: Color(0xFFFF9800),
    // Surface colors
    surface: Color(0xFF1C1B1F),
    surfaceVariant: Color(0xFF49454F),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
  );
}

/// Extension method to easily access HivesColors from ThemeData
extension HivesColorsExtension on ThemeData {
  HivesColors get hivesColors => extension<HivesColors>() ?? HivesColors.light;
}
