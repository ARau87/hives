import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/extensions/context_extensions.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_theme.dart';

/// Suppresses google_fonts font-loading errors expected in test environment.
void _suppressFontLoadErrors(WidgetTester tester) {
  final saved = FlutterError.onError;
  FlutterError.onError = (details) {
    final msg = details.exceptionAsString();
    if (msg.contains('allowRuntimeFetching') ||
        msg.contains('google_fonts') ||
        msg.contains('Failed to load font')) {
      return;
    }
    saved?.call(details);
  };
  addTearDown(() => FlutterError.onError = saved);
}

Widget _buildTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    home: Scaffold(body: child),
  );
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('HivesContextExtension', () {
    testWidgets('context.colors.honey matches AppColors.primary', (
      tester,
    ) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.colors.honey, AppColors.primary);
    });

    testWidgets('context.colors status fields match AppColors', (tester) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.colors.healthyStatus, AppColors.healthyStatus);
      expect(captured.colors.urgentStatus, AppColors.urgentStatus);
      expect(captured.colors.attentionStatus, AppColors.attentionStatus);
      expect(captured.colors.unknownStatus, AppColors.unknownStatus);
    });

    testWidgets('context.spacings.xs is 4.0 and .lg is 16.0', (tester) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.spacings.xs, 4.0);
      expect(captured.spacings.lg, 16.0);
    });

    testWidgets('context.colorScheme.primary matches AppColors.primary', (
      tester,
    ) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.colorScheme.primary, AppColors.primary);
    });

    testWidgets('context.textTheme is non-null', (tester) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.textTheme, isNotNull);
    });

    testWidgets('context.theme.useMaterial3 is true', (tester) async {
      _suppressFontLoadErrors(tester);
      late BuildContext captured;
      await tester.pumpWidget(
        _buildTestApp(
          child: Builder(builder: (ctx) {
            captured = ctx;
            return const Text('test');
          }),
        ),
      );
      await tester.pumpAndSettle();
      expect(captured.theme.useMaterial3, isTrue);
    });
  });
}
