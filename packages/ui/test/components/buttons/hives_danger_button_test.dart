import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/buttons/hives_danger_button.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesDangerButton', () {
    Widget buildWidget(HivesDangerButton button, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: Center(child: button)),
        );

    testWidgets('renders label and responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesDangerButton(label: 'Delete', onPressed: () => tapped = true),
      ));

      expect(find.text('Delete'), findsOneWidget);
      await tester.tap(find.byType(HivesDangerButton));
      expect(tapped, isTrue);
    });

    testWidgets('loading state shows spinner and disables press',
        (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesDangerButton(
          label: 'Delete',
          onPressed: () => tapped = true,
          isLoading: true,
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Delete'), findsNothing);
      await tester.tap(find.byType(HivesDangerButton));
      expect(tapped, isFalse);
    });

    testWidgets('disabled state reduces opacity', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesDangerButton(
          label: 'Delete',
          onPressed: () => tapped = true,
          isEnabled: false,
        ),
      ));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 0.5);
      await tester.tap(find.byType(HivesDangerButton));
      expect(tapped, isFalse);
    });

    testWidgets('renders with icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesDangerButton(
          label: 'Delete',
          onPressed: () {},
          icon: const Icon(Icons.delete),
          iconLeading: true,
        ),
      ));

      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders without error in dark mode', (tester) async {
      await tester.pumpWidget(
        buildWidget(
          HivesDangerButton(label: 'Delete', onPressed: () {}),
          theme: AppTheme.darkTheme,
        ),
      );

      expect(find.byType(HivesDangerButton), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
