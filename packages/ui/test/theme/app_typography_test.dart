import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/theme/app_typography.dart';

/// Suppresses google_fonts font-loading errors expected in test environment
/// (no bundled font assets, no network access).
void _suppressFontLoadErrors(WidgetTester tester) {
  final saved = FlutterError.onError;
  FlutterError.onError = (details) {
    final msg = details.exceptionAsString();
    if (msg.contains('allowRuntimeFetching') ||
        msg.contains('google_fonts') ||
        msg.contains('Failed to load font')) {
      return; // expected: no fonts bundled in test assets
    }
    saved?.call(details);
  };
  addTearDown(() => FlutterError.onError = saved);
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppTypography', () {
    group('Static style getters', () {
      testWidgets('display returns TextStyle with fontSize 32', (tester) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.display;
        await tester.pump();
        expect(style.fontSize, 32);
        expect(style.fontWeight, FontWeight.bold);
        expect(style.letterSpacing, -0.5);
      });

      testWidgets('titleLarge returns TextStyle with fontSize 22', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.titleLarge;
        await tester.pump();
        expect(style.fontSize, 22);
        expect(style.fontWeight, FontWeight.w600);
      });

      testWidgets('titleMedium returns TextStyle with fontSize 18', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.titleMedium;
        await tester.pump();
        expect(style.fontSize, 18);
        expect(style.fontWeight, FontWeight.w600);
      });

      testWidgets('bodyLarge returns TextStyle with fontSize 16', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.bodyLarge;
        await tester.pump();
        expect(style.fontSize, 16);
        expect(style.fontWeight, FontWeight.w500);
      });

      testWidgets('bodyMedium returns TextStyle with fontSize 15', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.bodyMedium;
        await tester.pump();
        expect(style.fontSize, 15);
        expect(style.fontWeight, FontWeight.w400);
      });

      testWidgets('label returns TextStyle with fontSize 13', (tester) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.label;
        await tester.pump();
        expect(style.fontSize, 13);
        expect(style.letterSpacing, 0.3);
      });

      testWidgets('caption returns TextStyle with fontSize 12', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        final style = AppTypography.caption;
        await tester.pump();
        expect(style.fontSize, 12);
        expect(style.letterSpacing, 0.2);
      });
    });

    group('textTheme()', () {
      testWidgets('returns non-null TextTheme', (tester) async {
        _suppressFontLoadErrors(tester);
        final theme = AppTypography.textTheme();
        await tester.pump();
        expect(theme, isNotNull);
      });

      testWidgets('textTheme has non-null displayLarge', (tester) async {
        _suppressFontLoadErrors(tester);
        final theme = AppTypography.textTheme();
        await tester.pump();
        expect(theme.displayLarge, isNotNull);
      });

      testWidgets('textTheme has non-null bodyLarge', (tester) async {
        _suppressFontLoadErrors(tester);
        final theme = AppTypography.textTheme();
        await tester.pump();
        expect(theme.bodyLarge, isNotNull);
      });

      testWidgets('textTheme has non-null labelLarge', (tester) async {
        _suppressFontLoadErrors(tester);
        final theme = AppTypography.textTheme();
        await tester.pump();
        expect(theme.labelLarge, isNotNull);
      });
    });
  });
}
