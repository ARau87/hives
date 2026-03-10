import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/forms/hives_form_section.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesFormSection', () {
    Widget buildWidget(HivesFormSection section, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(
            body: SingleChildScrollView(child: section),
          ),
        );

    testWidgets('renders title and chevron when collapsible', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          child: Text('Content'),
        ),
      ));

      expect(find.text('Details'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('starts collapsed by default', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          child: Text('Hidden Content'),
        ),
      ));

      // Content should not be visible (collapsed)
      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 0.0);
    });

    testWidgets('starts expanded when isInitiallyExpanded is true',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          isInitiallyExpanded: true,
          child: Text('Visible Content'),
        ),
      ));

      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 1.0);
    });

    testWidgets('expands and collapses on tap', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          child: Text('Content'),
        ),
      ));

      // Tap to expand
      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();

      final expandedTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(expandedTransition.sizeFactor.value, 1.0);

      // Tap to collapse
      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();

      final collapsedTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(collapsedTransition.sizeFactor.value, 0.0);
    });

    testWidgets('required variant has no chevron and is always visible',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection.required(
          title: 'Required Section',
          child: Text('Always Visible'),
        ),
      ));

      expect(find.text('Required Section'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsNothing);

      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 1.0);
    });

    testWidgets('required variant does not collapse on tap', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection.required(
          title: 'Required',
          child: Text('Content'),
        ),
      ));

      await tester.tap(find.text('Required'));
      await tester.pumpAndSettle();

      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 1.0);
    });

    testWidgets('shows 1px separator line above header', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          child: Text('Content'),
        ),
      ));

      final separator = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints != null &&
            widget.constraints!.maxHeight == 1.0,
      );
      expect(separator, findsOneWidget);
    });

    testWidgets('renders without exception in dark mode', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Dark Section',
          isInitiallyExpanded: true,
          child: Text('Dark Content'),
        ),
        theme: AppTheme.darkTheme,
      ));

      expect(find.text('Dark Section'), findsOneWidget);
      expect(find.text('Dark Content'), findsOneWidget);
    });

    testWidgets('chevron has semantic label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesFormSection(
          title: 'Details',
          child: Text('Content'),
        ),
      ));

      final icon = tester.widget<Icon>(find.byIcon(Icons.expand_more));
      expect(icon.semanticLabel, 'Toggle section');
    });
  });
}
