import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/feedback/snack_bar_service.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('SnackBarService', () {
    Widget buildApp({ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: const Scaffold(body: SizedBox.shrink()),
    );

    testWidgets('showSuccess displays message with check_circle icon', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showSuccess(context, 'Saved successfully');
      await tester.pump();
      expect(find.text('Saved successfully'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('showError displays message with error icon', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showError(context, 'Something went wrong');
      await tester.pump();
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('showInfo displays message with info icon', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showInfo(context, 'Tap a hive to inspect');
      await tester.pump();
      expect(find.text('Tap a hive to inspect'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('snackbar uses floating behavior', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showSuccess(context, 'Test');
      await tester.pump();
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.behavior, SnackBarBehavior.floating);
    });

    testWidgets('showError uses 4 second duration', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showError(context, 'Error');
      await tester.pump();
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.duration, const Duration(seconds: 4));
    });

    testWidgets('showSuccess uses 3 second duration', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showSuccess(context, 'Done');
      await tester.pump();
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.duration, const Duration(seconds: 3));
    });

    testWidgets('new snackbar dismisses current one', (tester) async {
      await tester.pumpWidget(buildApp());
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showSuccess(context, 'First message');
      await tester.pump();
      expect(find.text('First message'), findsOneWidget);
      SnackBarService.showError(context, 'Second message');
      await tester.pumpAndSettle();
      expect(find.text('Second message'), findsOneWidget);
      expect(find.text('First message'), findsNothing);
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildApp(theme: AppTheme.darkTheme));
      final context = tester.element(find.byType(Scaffold));
      SnackBarService.showSuccess(context, 'Dark mode test');
      await tester.pump();
      expect(find.text('Dark mode test'), findsOneWidget);
    });
  });
}
