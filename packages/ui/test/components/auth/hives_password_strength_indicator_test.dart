import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/auth/hives_password_strength_indicator.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesPasswordStrengthIndicator', () {
    Widget buildWidget(String password, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(
        body: HivesPasswordStrengthIndicator(password: password),
      ),
    );

    testWidgets('empty password shows all rules unsatisfied', (tester) async {
      await tester.pumpWidget(buildWidget(''));

      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(4));
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('password with 8+ chars satisfies length rule', (tester) async {
      await tester.pumpWidget(buildWidget('abcdefgh'));
      await tester.pumpAndSettle();

      // length + lowercase satisfied, uppercase + digit unsatisfied
      expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(2));
    });

    testWidgets('password with uppercase satisfies uppercase rule',
        (tester) async {
      await tester.pumpWidget(buildWidget('A'));
      await tester.pumpAndSettle();

      // Only uppercase satisfied
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(3));
    });

    testWidgets('password with digit satisfies digit rule', (tester) async {
      await tester.pumpWidget(buildWidget('1'));
      await tester.pumpAndSettle();

      // Only digit satisfied
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsNWidgets(3));
    });

    testWidgets('strong password satisfies all rules', (tester) async {
      await tester.pumpWidget(buildWidget('MyPass1x'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsNWidgets(4));
      expect(find.byIcon(Icons.circle_outlined), findsNothing);
    });

    testWidgets('displays all 4 rule labels', (tester) async {
      await tester.pumpWidget(buildWidget(''));

      expect(find.text('8+ characters'), findsOneWidget);
      expect(find.text('One uppercase letter (A-Z)'), findsOneWidget);
      expect(find.text('One lowercase letter (a-z)'), findsOneWidget);
      expect(find.text('One digit (0-9)'), findsOneWidget);
    });

    testWidgets('renders without error in dark mode', (tester) async {
      await tester.pumpWidget(
        buildWidget('Test1234', theme: AppTheme.darkTheme),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HivesPasswordStrengthIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
