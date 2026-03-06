import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/auth/hives_divider_with_label.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesDividerWithLabel', () {
    Widget buildWidget(String label, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(
        body: Center(child: HivesDividerWithLabel(label: label)),
      ),
    );

    testWidgets('renders label text correctly', (tester) async {
      await tester.pumpWidget(buildWidget('or'));

      expect(find.text('or'), findsOneWidget);
    });

    testWidgets('renders two dividers flanking the label', (tester) async {
      await tester.pumpWidget(buildWidget('or'));

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('renders with custom label', (tester) async {
      await tester.pumpWidget(buildWidget('continue with'));

      expect(find.text('continue with'), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('renders without error in dark mode', (tester) async {
      await tester.pumpWidget(
        buildWidget('or', theme: AppTheme.darkTheme),
      );

      expect(find.byType(HivesDividerWithLabel), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
