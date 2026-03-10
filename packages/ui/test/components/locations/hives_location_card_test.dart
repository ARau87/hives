import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/locations/hives_location_card.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesLocationCard', () {
    Widget buildWidget(HivesLocationCard card, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: card),
        );

    testWidgets('healthy variant renders name, summary, chevron, and status icon',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives · All healthy',
          status: HivesLocationStatus.healthy,
        ),
      ));

      expect(find.text('Meadow Apiary'), findsOneWidget);
      expect(find.text('4 hives · All healthy'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('attention variant shows warning icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Forest Yard',
          statusSummary: '3 hives · 1 needs attention',
          status: HivesLocationStatus.attention,
        ),
      ));

      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('urgent variant shows error icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Hilltop Bees',
          statusSummary: '2 hives · 1 urgent',
          status: HivesLocationStatus.urgent,
        ),
      ));

      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('empty variant shows add icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'New Spot',
          statusSummary: 'No hives yet',
          status: HivesLocationStatus.empty,
        ),
      ));

      expect(find.text('No hives yet'), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading state hides text content', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
          isLoading: true,
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Meadow Apiary'), findsNothing);
      expect(find.text('4 hives'), findsNothing);
    });

    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
          onTap: () => tapped = true,
        ),
      ));

      await tester.tap(find.byType(HivesLocationCard));
      expect(tapped, isTrue);
    });

    testWidgets('does NOT fire onTap when isLoading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
          isLoading: true,
          onTap: () => tapped = true,
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.byType(HivesLocationCard));
      expect(tapped, isFalse);
    });

    testWidgets('shows placeholder icon when no image provided',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
        ),
      ));

      expect(find.byIcon(Icons.landscape_outlined), findsOneWidget);
    });

    testWidgets('shows provided image instead of placeholder',
        (tester) async {
      // 1x1 transparent PNG as a minimal valid image
      final image = MemoryImage(Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
        0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR chunk
        0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1x1
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
        0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
        0x54, 0x78, 0x9C, 0x62, 0x00, 0x00, 0x00, 0x02,
        0x00, 0x01, 0xE5, 0x27, 0xDE, 0xFC, 0x00, 0x00,
        0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
        0x60, 0x82, // IEND chunk
      ]));

      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
          image: image,
        ),
      ));

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.landscape_outlined), findsNothing);
    });

    testWidgets('renders in dark mode without exception', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesLocationCard(
          locationName: 'Meadow Apiary',
          statusSummary: '4 hives',
          status: HivesLocationStatus.healthy,
        ),
        theme: AppTheme.darkTheme,
      ));

      expect(find.byType(HivesLocationCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
