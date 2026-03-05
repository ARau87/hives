import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/surfaces/hives_bottom_sheet.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('showHivesBottomSheet', () {
    Widget buildTestApp({required Widget Function(BuildContext) body}) {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Builder(builder: body),
        ),
      );
    }

    testWidgets('displays builder content when opened', (tester) async {
      await tester.pumpWidget(buildTestApp(
        body: (context) => ElevatedButton(
          onPressed: () => showHivesBottomSheet<void>(
            context: context,
            builder: (_) => const Text('Sheet Content'),
          ),
          child: const Text('Open'),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Sheet Content'), findsOneWidget);
    });

    testWidgets('shows drag handle bar', (tester) async {
      await tester.pumpWidget(buildTestApp(
        body: (context) => ElevatedButton(
          onPressed: () => showHivesBottomSheet<void>(
            context: context,
            builder: (_) => const SizedBox(height: 100),
          ),
          child: const Text('Open'),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Container(width: 40, height: 4) renders as a ConstrainedBox with tight
      // constraints — verify the drag handle has the expected dimensions.
      final handleConstraints = tester.widgetList<ConstrainedBox>(
        find.byType(ConstrainedBox),
      ).where((c) =>
        c.constraints.minWidth == AppSpacing.dragHandleWidth &&
        c.constraints.maxWidth == AppSpacing.dragHandleWidth &&
        c.constraints.minHeight == AppSpacing.dragHandleHeight &&
        c.constraints.maxHeight == AppSpacing.dragHandleHeight,
      );
      expect(
        handleConstraints.isNotEmpty,
        isTrue,
        reason: 'Expected drag handle with dimensions '
            '${AppSpacing.dragHandleWidth}×${AppSpacing.dragHandleHeight}',
      );
    });

    testWidgets('uses modalTopRadius shape (28px top corners)', (tester) async {
      await tester.pumpWidget(buildTestApp(
        body: (context) => ElevatedButton(
          onPressed: () => showHivesBottomSheet<void>(
            context: context,
            builder: (_) => const SizedBox(height: 100),
          ),
          child: const Text('Open'),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // BottomSheet widget exposes its shape — verify it uses modalTopRadius (28px)
      final sheet = tester.widget<BottomSheet>(find.byType(BottomSheet));
      expect(sheet.shape, isA<RoundedRectangleBorder>());
      final shape = sheet.shape! as RoundedRectangleBorder;
      expect(shape.borderRadius, equals(AppSpacing.modalTopRadius));
    });

    testWidgets('can return a value via Future<T?>', (tester) async {
      String? result;

      await tester.pumpWidget(buildTestApp(
        body: (context) => ElevatedButton(
          onPressed: () async {
            result = await showHivesBottomSheet<String>(
              context: context,
              builder: (_) => ElevatedButton(
                onPressed: () => Navigator.of(context).pop('hello'),
                child: const Text('Return'),
              ),
            );
          },
          child: const Text('Open'),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Return'));
      await tester.pumpAndSettle();

      expect(result, equals('hello'));
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          body: Builder(builder: (context) => ElevatedButton(
            onPressed: () => showHivesBottomSheet<void>(
              context: context,
              builder: (_) => const Text('Dark Content'),
            ),
            child: const Text('Open'),
          )),
        ),
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Dark Content'), findsOneWidget);
    });
  });
}
