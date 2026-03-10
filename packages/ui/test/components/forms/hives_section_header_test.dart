import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/forms/hives_section_header.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesSectionHeader', () {
    Widget buildWidget(HivesSectionHeader header, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: header),
        );

    testWidgets('standalone variant renders title only', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesSectionHeader(title: 'My Section'),
      ));

      expect(find.text('My Section'), findsOneWidget);
    });

    testWidgets('withAction variant renders title and action label',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesSectionHeader(
          title: 'Hives',
          actionLabel: 'See All',
        ),
      ));

      expect(find.text('Hives'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);
    });

    testWidgets('action callback fires on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesSectionHeader(
          title: 'Tasks',
          actionLabel: 'View All',
          onAction: () => tapped = true,
        ),
      ));

      await tester.tap(find.text('View All'));
      expect(tapped, isTrue);
    });

    testWidgets('action label not rendered when null', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesSectionHeader(title: 'Solo Title'),
      ));

      // Only the title should be present, no InkWell for action
      expect(find.text('Solo Title'), findsOneWidget);
      expect(find.byType(InkWell), findsNothing);
    });

    testWidgets('renders without exception in dark mode', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesSectionHeader(
          title: 'Dark Header',
          actionLabel: 'Action',
        ),
        theme: AppTheme.darkTheme,
      ));

      expect(find.text('Dark Header'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
    });

    testWidgets('uses space-between layout', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesSectionHeader(
          title: 'Title',
          actionLabel: 'Action',
        ),
      ));

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });
  });
}
