import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/locations/hives_map_preview_widget.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesMapPreviewWidget', () {
    Widget buildWidget(HivesMapPreviewWidget widget, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: widget),
        );

    testWidgets('hasPin true shows location_pin icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesMapPreviewWidget(hasPin: true, onTap: () {}),
      ));

      expect(find.byIcon(Icons.location_pin), findsOneWidget);
    });

    testWidgets('hasPin false shows noPinSet placeholder', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesMapPreviewWidget(hasPin: false, onTap: () {}),
      ));

      expect(find.text('Tap to set location'), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
      expect(find.byIcon(Icons.location_pin), findsNothing);
    });

    testWidgets('loading state renders without exception, no tap fires',
        (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesMapPreviewWidget(
          isLoading: true,
          onTap: () => tapped = true,
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(HivesMapPreviewWidget), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(HivesMapPreviewWidget));
      expect(tapped, isFalse);
    });

    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesMapPreviewWidget(
          hasPin: true,
          onTap: () => tapped = true,
        ),
      ));

      await tester.tap(find.byType(HivesMapPreviewWidget));
      expect(tapped, isTrue);
    });

    testWidgets('renders in dark mode without exception', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesMapPreviewWidget(hasPin: true, onTap: () {}),
        theme: AppTheme.darkTheme,
      ));

      expect(find.byType(HivesMapPreviewWidget), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
