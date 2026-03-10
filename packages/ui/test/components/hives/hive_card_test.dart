import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/hives/hive_card.dart';
import 'package:ui/src/components/hives/hives_hive_status.dart';
import 'package:ui/src/theme/app_theme.dart';

// Minimal 1×1 transparent PNG for image tests
final _kTransparentPng = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x62, 0x00, 0x00, 0x00, 0x02,
  0x00, 0x01, 0xE5, 0x27, 0xDE, 0xFC, 0x00, 0x00,
  0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
]);

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HiveCard', () {
    Widget buildWidget(HiveCard card, {ThemeData? theme}) => MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: card),
        );

    testWidgets('renders hive name', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
        ),
      ));

      expect(find.text('Hive Alpha'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders status summary when provided', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          statusSummary: '3 days ago',
        ),
      ));

      expect(find.text('3 days ago'), findsOneWidget);
    });

    testWidgets('card is 160px tall', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
        ),
      ));

      expect(tester.getSize(find.byType(HiveCard)).height, 160);
    });

    testWidgets('shows hexagon placeholder when image is null', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
        ),
      ));

      expect(find.byIcon(Icons.hexagon_outlined), findsOneWidget);
    });

    testWidgets('shows Image widget and no placeholder when image provided',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          image: MemoryImage(_kTransparentPng),
        ),
      ));

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.hexagon_outlined), findsNothing);
    });

    testWidgets('healthy status shows check_circle icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
        ),
      ));

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('attention status shows warning icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Beta',
          status: HivesHiveStatus.attention,
        ),
      ));

      expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
    });

    testWidgets('urgent status shows error icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Gamma',
          status: HivesHiveStatus.urgent,
        ),
      ));

      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('unknown status shows help_outline icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Delta',
          status: HivesHiveStatus.unknown,
        ),
      ));

      expect(find.byIcon(Icons.help_outline), findsOneWidget);
    });

    testWidgets('chevron_right icon is present', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          onTap: () {},
        ),
      ));

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          onTap: () => tapped = true,
        ),
      ));

      await tester.tap(find.byType(HiveCard));
      expect(tapped, isTrue);
    });

    testWidgets('does NOT fire onTap when isLoading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          isLoading: true,
          onTap: () => tapped = true,
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.byType(HiveCard));
      expect(tapped, isFalse);
    });

    testWidgets('loading state hides text content', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          statusSummary: 'Queenright',
          isLoading: true,
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Hive Alpha'), findsNothing);
      expect(find.text('Queenright'), findsNothing);
    });

    testWidgets('shimmer animation runs without exception', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          isLoading: true,
        ),
      ));

      await tester.pump(const Duration(milliseconds: 600));
      expect(tester.takeException(), isNull);

      await tester.pump(const Duration(milliseconds: 600));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders in dark mode without exception', (tester) async {
      await tester.pumpWidget(buildWidget(
        HiveCard(
          hiveName: 'Hive Alpha',
          status: HivesHiveStatus.healthy,
          statusSummary: '3 days ago',
        ),
        theme: AppTheme.darkTheme,
      ));

      expect(find.byType(HiveCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
