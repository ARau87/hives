import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/auth/hives_auth_header.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesAuthHeader', () {
    Widget buildWidget(HivesAuthHeaderVariant variant, {ThemeData? theme}) =>
        MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: Center(child: HivesAuthHeader(variant: variant))),
        );

    testWidgets('signIn variant renders correct tagline', (tester) async {
      await tester.pumpWidget(buildWidget(HivesAuthHeaderVariant.signIn));

      expect(find.text('hives'), findsOneWidget);
      expect(find.text('Welcome back to your hives'), findsOneWidget);
      expect(find.byIcon(Icons.hive), findsOneWidget);
    });

    testWidgets('signUp variant renders correct tagline', (tester) async {
      await tester.pumpWidget(buildWidget(HivesAuthHeaderVariant.signUp));

      expect(find.text('hives'), findsOneWidget);
      expect(find.text('Start managing your hives today'), findsOneWidget);
      expect(find.byIcon(Icons.hive), findsOneWidget);
    });

    testWidgets('forgotPassword variant renders correct tagline',
        (tester) async {
      await tester
          .pumpWidget(buildWidget(HivesAuthHeaderVariant.forgotPassword));

      expect(find.text('hives'), findsOneWidget);
      expect(find.text('Reset your password'), findsOneWidget);
      expect(find.byIcon(Icons.hive), findsOneWidget);
    });

    testWidgets('bee icon has 72px size', (tester) async {
      await tester.pumpWidget(buildWidget(HivesAuthHeaderVariant.signIn));

      final icon = tester.widget<Icon>(find.byIcon(Icons.hive));
      expect(icon.size, 72);
    });

    testWidgets('bee icon has semantic label', (tester) async {
      await tester.pumpWidget(buildWidget(HivesAuthHeaderVariant.signIn));

      final icon = tester.widget<Icon>(find.byIcon(Icons.hive));
      expect(icon.semanticLabel, 'Hives bee icon');
    });

    testWidgets('renders without error in dark mode', (tester) async {
      await tester.pumpWidget(
        buildWidget(HivesAuthHeaderVariant.signIn, theme: AppTheme.darkTheme),
      );

      expect(find.byType(HivesAuthHeader), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
