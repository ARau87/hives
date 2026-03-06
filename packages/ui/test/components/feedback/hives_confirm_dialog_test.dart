import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/buttons/hives_danger_button.dart';
import 'package:ui/src/components/buttons/primary_button.dart';
import 'package:ui/src/components/buttons/text_button.dart';
import 'package:ui/src/components/feedback/hives_confirm_dialog.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesConfirmDialog', () {
    Widget buildWidget(HivesConfirmDialog dialog) => MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(body: dialog),
        );

    testWidgets('danger variant renders with red confirm button',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesConfirmDialog(
          icon: Icons.delete,
          title: 'Delete hive?',
          body: 'This action cannot be undone.',
          confirmLabel: 'Delete',
          onConfirm: () {},
          variant: HivesConfirmDialogVariant.danger,
        ),
      ));

      expect(find.text('Delete hive?'), findsOneWidget);
      expect(find.text('This action cannot be undone.'), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byType(HivesDangerButton), findsOneWidget);
      expect(find.byType(PlainTextButton), findsOneWidget);
    });

    testWidgets('warning variant renders with amber confirm button',
        (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesConfirmDialog(
          icon: Icons.warning,
          title: 'Are you sure?',
          body: 'This will reset your settings.',
          confirmLabel: 'Proceed',
          onConfirm: () {},
          variant: HivesConfirmDialogVariant.warning,
        ),
      ));

      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('This will reset your settings.'), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.byType(HivesDangerButton), findsNothing);
    });

    testWidgets('confirm callback fires on confirm tap', (tester) async {
      var confirmed = false;
      await tester.pumpWidget(buildWidget(
        HivesConfirmDialog(
          icon: Icons.delete,
          title: 'Delete?',
          body: 'Gone forever.',
          confirmLabel: 'Delete',
          onConfirm: () => confirmed = true,
        ),
      ));

      await tester.tap(find.byType(HivesDangerButton));
      expect(confirmed, isTrue);
    });

    testWidgets('cancel callback fires on cancel tap', (tester) async {
      var cancelled = false;
      await tester.pumpWidget(buildWidget(
        HivesConfirmDialog(
          icon: Icons.delete,
          title: 'Delete?',
          body: 'Gone forever.',
          confirmLabel: 'Delete',
          onConfirm: () {},
          onCancel: () => cancelled = true,
        ),
      ));

      await tester.tap(find.byType(PlainTextButton));
      expect(cancelled, isTrue);
    });

    testWidgets('displays icon, title, and body', (tester) async {
      await tester.pumpWidget(buildWidget(
        HivesConfirmDialog(
          icon: Icons.warning_amber,
          title: 'Custom Title',
          body: 'Custom body text here.',
          confirmLabel: 'OK',
          onConfirm: () {},
        ),
      ));

      expect(find.byIcon(Icons.warning_amber), findsOneWidget);
      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.text('Custom body text here.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
