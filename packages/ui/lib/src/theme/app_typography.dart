import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Static typography styles using the Poppins font from google_fonts.
///
/// Provides named text styles matching the UX specification type scale.
/// These are runtime getters (not const) because GoogleFonts creates instances.
/// Use [textTheme] to get a full [TextTheme] for [ThemeData] integration.
abstract final class AppTypography {
  /// 32px Bold, letterSpacing -0.5 — used for large display headings.
  static TextStyle get display => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// 22px SemiBold — used for screen titles.
  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// 18px SemiBold — used for section headers.
  static TextStyle get titleMedium => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// 16px Medium — used for primary body content; 16px base for field readability.
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  /// 15px Regular — used for secondary body content.
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// 13px SemiBold, letterSpacing +0.3 — used for labels and chips.
  static TextStyle get label => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  /// 12px Medium, letterSpacing +0.2 — used for captions and helper text.
  static TextStyle get caption => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Returns a full [TextTheme] with Poppins applied to all text roles.
  /// Pass directly to [ThemeData.textTheme].
  static TextTheme textTheme() => GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      bodyMedium: TextStyle(fontSize: 15, letterSpacing: 0),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    ),
  );
}
