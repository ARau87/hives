import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/forms/hives_date_picker.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesDatePicker', () {
    Widget buildWidget(HivesDatePicker picker, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: picker),
        );

    testWidgets('empty variant shows placeholder hint', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(),
      ));

      expect(find.text('Select date'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('filled variant shows formatted date', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesDatePicker(
          selectedDate: DateTime(2025, 3, 15),
        ),
      ));

      expect(find.text('15 March 2025'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('shows label when provided', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(label: 'Birth Date'),
      ));

      expect(find.text('Birth Date'), findsOneWidget);
      expect(find.text('Select date'), findsOneWidget);
    });

    testWidgets('disabled state blocks interaction', (tester) async {
      var called = false;
      await tester.pumpWidget(buildWidget(
        HivesDatePicker(
          isEnabled: false,
          onDateSelected: (_) => called = true,
        ),
      ));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(called, isFalse);
    });

    testWidgets('error variant shows error message', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(errorText: 'Date is required'),
      ));

      expect(find.text('Date is required'), findsOneWidget);
    });

    testWidgets('tap opens date picker when enabled', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(),
      ));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // DatePicker dialog should be visible
      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('custom hint text is displayed', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(hint: 'Pick a date'),
      ));

      expect(find.text('Pick a date'), findsOneWidget);
    });

    testWidgets('renders without exception in dark mode', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesDatePicker(
          selectedDate: DateTime(2025, 6, 1),
          label: 'Test',
        ),
        theme: AppTheme.darkTheme,
      ));

      expect(find.text('1 June 2025'), findsOneWidget);
    });

    testWidgets('calendar icon has semantic label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesDatePicker(),
      ));

      final icon = tester.widget<Icon>(find.byIcon(Icons.calendar_today));
      expect(icon.semanticLabel, 'Select date');
    });
  });
}
