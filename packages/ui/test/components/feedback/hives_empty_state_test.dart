import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/buttons/primary_button.dart';
import 'package:ui/src/components/feedback/hives_empty_state.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesEmptyState', () {
    Widget buildWidget(HivesEmptyState emptyState) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(body: emptyState),
        );

    testWidgets('noLocations variant renders correct content', (tester) async {
      await tester.pumpWidget(buildWidget(HivesEmptyState.noLocations()));

      expect(find.text('No locations yet'), findsOneWidget);
      expect(
          find.text('Add your first apiary to get started'), findsOneWidget);
      expect(find.byIcon(Icons.location_off), findsOneWidget);
      expect(find.byType(PrimaryButton), findsNothing);
    });

    testWidgets('noHives variant renders correct content', (tester) async {
      await tester.pumpWidget(buildWidget(HivesEmptyState.noHives()));

      expect(find.text('No hives here'), findsOneWidget);
      expect(
          find.text('Add your first hive to this location'), findsOneWidget);
      expect(find.byIcon(Icons.hive), findsOneWidget);
    });

    testWidgets('noTasks variant renders correct content', (tester) async {
      await tester.pumpWidget(buildWidget(HivesEmptyState.noTasks()));

      expect(find.text('All caught up!'), findsOneWidget);
      expect(find.text('No tasks need your attention right now'),
          findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('noResults variant renders correct content', (tester) async {
      await tester.pumpWidget(buildWidget(HivesEmptyState.noResults()));

      expect(find.text('No results found'), findsOneWidget);
      expect(find.text('Try adjusting your search or filters'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('CTA button fires callback when provided', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesEmptyState.noLocations(
          ctaLabel: 'Add Location',
          onCta: () => tapped = true,
        ),
      ));

      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('Add Location'), findsOneWidget);
      await tester.tap(find.byType(PrimaryButton));
      expect(tapped, isTrue);
    });

    testWidgets('CTA button hidden when no callback provided', (tester) async {
      await tester.pumpWidget(buildWidget(HivesEmptyState.noLocations()));

      expect(find.byType(PrimaryButton), findsNothing);
    });
  });
}
