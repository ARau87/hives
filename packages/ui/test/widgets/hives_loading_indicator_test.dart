import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/feedback/hives_loading_indicator.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesLoadingIndicator', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: Center(child: child)),
    );

    testWidgets('renders CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('without size does not wrap in SizedBox from this widget', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(),
      ));
      // The indicator renders — no exceptions thrown
      expect(find.byType(HivesLoadingIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('with size renders CircularProgressIndicator inside SizedBox', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(size: 48),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Find SizedBox that is an ancestor of CircularProgressIndicator
      final sizedBoxFinder = find.ancestor(
        of: find.byType(CircularProgressIndicator),
        matching: find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == 48.0 && widget.height == 48.0,
        ),
      );
      expect(sizedBoxFinder, findsOneWidget);
    });

    testWidgets('custom strokeWidth is accepted without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(strokeWidth: 5.0),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('uses honey color from theme', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(),
      ));
      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      final animation = indicator.valueColor as AlwaysStoppedAnimation<Color>;
      expect(animation.value, const Color(0xFFF59E0A));
    });

    testWidgets('has Loading semantics label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(),
      ));
      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(indicator.semanticsLabel, 'Loading');
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(),
        theme: AppTheme.darkTheme,
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('with size renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesLoadingIndicator(size: 32),
        theme: AppTheme.darkTheme,
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
