import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/feedback/status_badge.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('StatusBadge', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

    testWidgets('healthy variant renders check_circle icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
      ));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('attention variant renders warning icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.attention),
      ));
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('urgent variant renders error icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.urgent),
      ));
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('unknown variant renders help_outline icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.unknown),
      ));
      expect(find.byIcon(Icons.help_outline), findsOneWidget);
    });

    testWidgets('healthy variant does not render other variant icons', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
      ));
      expect(find.byIcon(Icons.error), findsNothing);
      expect(find.byIcon(Icons.warning), findsNothing);
      expect(find.byIcon(Icons.help_outline), findsNothing);
    });

    testWidgets('all variants render without throwing', (tester) async {
      for (final variant in HivesStatusVariant.values) {
        await tester.pumpWidget(buildWidget(StatusBadge(variant: variant)));
        expect(find.byType(StatusBadge), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
        theme: AppTheme.darkTheme,
      ));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('custom size changes badge dimensions', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy, size: 32),
      ));
      final badgeSize = tester.getSize(find.byType(StatusBadge));
      expect(badgeSize.width, 32.0);
      expect(badgeSize.height, 32.0);
    });

    testWidgets('custom size scales icon proportionally', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy, size: 32),
      ));
      final icon = tester.widget<Icon>(find.byIcon(Icons.check_circle));
      expect(icon.size, 32 * 0.6);
    });

    testWidgets('healthy variant has semantic label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const StatusBadge(variant: HivesStatusVariant.healthy),
      ));
      final icon = tester.widget<Icon>(find.byIcon(Icons.check_circle));
      expect(icon.semanticLabel, 'Healthy status');
    });

    testWidgets('all variants render in dark mode without error', (tester) async {
      for (final variant in HivesStatusVariant.values) {
        await tester.pumpWidget(buildWidget(
          StatusBadge(variant: variant),
          theme: AppTheme.darkTheme,
        ));
        expect(find.byType(StatusBadge), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });
  });
}
