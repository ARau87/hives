import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/buttons/secondary_button.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('SecondaryButton', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: Center(child: child)),
    );

    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(buildWidget(
        SecondaryButton(label: 'Cancel', onPressed: () {}),
      ));
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('fires onPressed callback when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(buildWidget(
        SecondaryButton(
          label: 'Tap Me',
          onPressed: () => pressed = true,
        ),
      ));
      await tester.tap(find.byType(OutlinedButton));
      expect(pressed, isTrue);
    });

    testWidgets('is disabled when isEnabled is false', (tester) async {
      var pressed = false;
      await tester.pumpWidget(buildWidget(
        SecondaryButton(
          label: 'Disabled',
          onPressed: () => pressed = true,
          isEnabled: false,
        ),
      ));
      // OutlinedButton with null onPressed is disabled
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button.onPressed, isNull);
      expect(pressed, isFalse);
    });

    testWidgets('is disabled when isLoading is true', (tester) async {
      var pressed = false;
      await tester.pumpWidget(buildWidget(
        SecondaryButton(
          label: 'Loading',
          onPressed: () => pressed = true,
          isLoading: true,
        ),
      ));
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button.onPressed, isNull);
      expect(pressed, isFalse);
    });

    testWidgets('uses AppSpacing.buttonHeight (54px) as minimum height', (tester) async {
      await tester.pumpWidget(buildWidget(
        SecondaryButton(label: 'Test', onPressed: () {}),
      ));
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      // Verify the style uses buttonHeight
      final style = button.style;
      final minSize = style?.minimumSize?.resolve({});
      expect(minSize?.height, equals(AppSpacing.buttonHeight));
    });

    testWidgets('uses AppSpacing.buttonRadius (16px) as border radius', (tester) async {
      await tester.pumpWidget(buildWidget(
        SecondaryButton(label: 'Test', onPressed: () {}),
      ));
      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final style = button.style;
      final shape = style?.shape?.resolve({}) as RoundedRectangleBorder?;
      final radius = shape?.borderRadius;
      // AppSpacing.buttonRadius = BorderRadius.all(Radius.circular(16))
      expect(radius, equals(AppSpacing.buttonRadius));
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        SecondaryButton(label: 'Dark', onPressed: () {}),
        theme: AppTheme.darkTheme,
      ));
      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('renders optional icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        SecondaryButton(
          label: 'With Icon',
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
