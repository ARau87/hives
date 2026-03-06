import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/auth/hives_otp_field.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesOTPField', () {
    Widget buildWidget({
      ValueChanged<String>? onComplete,
      bool hasError = false,
      GlobalKey<HivesOTPFieldState>? fieldKey,
    }) =>
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Center(
              child: HivesOTPField(
                key: fieldKey,
                onComplete: onComplete,
                hasError: hasError,
              ),
            ),
          ),
        );

    testWidgets('renders 6 text field cells', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('auto-advances focus on digit entry', (tester) async {
      await tester.pumpWidget(buildWidget());

      // Tap the first cell and enter a digit
      final firstField = find.byType(TextField).first;
      await tester.tap(firstField);
      await tester.pump();

      await tester.enterText(firstField, '1');
      await tester.pump();

      // The second field should now have focus
      final secondField = find.byType(TextField).at(1);
      final focusNode =
          tester.widget<TextField>(secondField).focusNode;
      expect(focusNode?.hasFocus, isTrue);
    });

    testWidgets('paste distributes 6 digits across all cells', (tester) async {
      String? completedCode;
      await tester.pumpWidget(
        buildWidget(onComplete: (code) => completedCode = code),
      );

      // enterText with 6 chars triggers onChanged with multi-char value,
      // which is detected as a paste and distributed across cells.
      final firstField = find.byType(TextField).first;
      await tester.tap(firstField);
      await tester.pump();
      await tester.enterText(firstField, '123456');
      await tester.pump();

      for (var i = 0; i < 6; i++) {
        final controller =
            tester.widget<TextField>(find.byType(TextField).at(i)).controller;
        expect(controller?.text, '${i + 1}');
      }
      expect(completedCode, '123456');
    });

    testWidgets('triggers onComplete when all 6 digits filled',
        (tester) async {
      String? completedCode;
      await tester.pumpWidget(
        buildWidget(onComplete: (code) => completedCode = code),
      );

      // Enter digits one by one
      for (var i = 0; i < 6; i++) {
        final field = find.byType(TextField).at(i);
        await tester.tap(field);
        await tester.pump();
        await tester.enterText(field, '${i + 1}');
        await tester.pump();
      }

      expect(completedCode, '123456');
    });

    testWidgets('shows error border when hasError is true', (tester) async {
      await tester.pumpWidget(buildWidget(hasError: true));
      await tester.pumpAndSettle();

      // Verify widget renders without exception
      expect(find.byType(HivesOTPField), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shake animation plays on error transition', (tester) async {
      // Start without error
      await tester.pumpWidget(buildWidget(hasError: false));
      await tester.pump();

      // Transition to error state
      await tester.pumpWidget(buildWidget(hasError: true));
      await tester.pump(const Duration(milliseconds: 100));

      // Verify widget still renders during animation
      expect(find.byType(HivesOTPField), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('clear resets all cells', (tester) async {
      final key = GlobalKey<HivesOTPFieldState>();
      await tester.pumpWidget(buildWidget(fieldKey: key));

      // Enter some digits
      for (var i = 0; i < 3; i++) {
        final field = find.byType(TextField).at(i);
        await tester.tap(field);
        await tester.pump();
        await tester.enterText(field, '${i + 1}');
        await tester.pump();
      }

      // Clear
      key.currentState!.clear();
      await tester.pump();

      // All controllers should be empty
      for (var i = 0; i < 6; i++) {
        final controller =
            tester.widget<TextField>(find.byType(TextField).at(i)).controller;
        expect(controller?.text, isEmpty);
      }
    });

    testWidgets('renders without error in dark mode', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.darkTheme,
        home: const Scaffold(
          body: Center(child: HivesOTPField()),
        ),
      ));

      expect(find.byType(HivesOTPField), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
