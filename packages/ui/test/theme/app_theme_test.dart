import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_theme.dart';

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

  group('AppTheme', () {
    group('lightTheme', () {
      testWidgets('is not null', (tester) async {
        _suppressFontLoadErrors(tester);
        expect(AppTheme.lightTheme, isNotNull);
        await tester.pump();
      });

      testWidgets('useMaterial3 is true', (tester) async {
        _suppressFontLoadErrors(tester);
        expect(AppTheme.lightTheme.useMaterial3, isTrue);
        await tester.pump();
      });

      testWidgets('colorScheme.primary matches AppColors.primary', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        expect(AppTheme.lightTheme.colorScheme.primary, AppColors.primary);
        await tester.pump();
      });

      testWidgets('colorScheme.secondary matches AppColors.secondary', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        expect(
          AppTheme.lightTheme.colorScheme.secondary,
          AppColors.secondary,
        );
        await tester.pump();
      });

      testWidgets('colorScheme.error matches AppColors.urgentStatus', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        expect(
          AppTheme.lightTheme.colorScheme.error,
          AppColors.urgentStatus,
        );
        await tester.pump();
      });

      testWidgets('renders MaterialApp without error', (tester) async {
        _suppressFontLoadErrors(tester);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: const Scaffold(body: Text('test')),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('test'), findsOneWidget);
      });

      testWidgets('widget tree uses Material 3 and correct primary', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: const Scaffold(body: Text('verify')),
          ),
        );
        await tester.pumpAndSettle();
        final theme = Theme.of(tester.element(find.text('verify')));
        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.primary, AppColors.primary);
      });
    });

    group('darkTheme', () {
      testWidgets('is not null', (tester) async {
        _suppressFontLoadErrors(tester);
        expect(AppTheme.darkTheme, isNotNull);
        await tester.pump();
      });

      testWidgets('useMaterial3 is true', (tester) async {
        _suppressFontLoadErrors(tester);
        expect(AppTheme.darkTheme.useMaterial3, isTrue);
        await tester.pump();
      });

      testWidgets('dark theme renders MaterialApp without error', (
        tester,
      ) async {
        _suppressFontLoadErrors(tester);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: const Scaffold(body: Text('dark test')),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('dark test'), findsOneWidget);
      });
    });
  });
}
