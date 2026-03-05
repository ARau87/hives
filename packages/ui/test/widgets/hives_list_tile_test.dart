import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/surfaces/hives_list_tile.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('HivesListTile', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

    testWidgets('renders title widget', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(title: Text('My Title')),
      ));
      expect(find.text('My Title'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(
          title: Text('Title'),
          subtitle: Text('Subtitle'),
        ),
      ));
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('renders leading widget when provided', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(
          title: Text('Title'),
          leading: Icon(Icons.star),
        ),
      ));
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders trailing widget when provided', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(
          title: Text('Title'),
          trailing: Icon(Icons.arrow_forward),
        ),
      ));
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('fires onTap callback when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesListTile(
          title: const Text('Title'),
          onTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });

    testWidgets('does not fire onTap when isEnabled is false', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildWidget(
        HivesListTile(
          title: const Text('Title'),
          onTap: () => tapped = true,
          isEnabled: false,
        ),
      ));
      await tester.tap(find.byType(ListTile), warnIfMissed: false);
      expect(tapped, isFalse);
    });

    testWidgets('shows Divider when showDivider is true', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(
          title: Text('Title'),
          showDivider: true,
        ),
      ));
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('does not show Divider when showDivider is false', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(title: Text('Title')),
      ));
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const HivesListTile(
          title: Text('Dark Title'),
          subtitle: Text('Dark Subtitle'),
        ),
        theme: AppTheme.darkTheme,
      ));
      expect(find.text('Dark Title'), findsOneWidget);
      expect(find.text('Dark Subtitle'), findsOneWidget);
    });
  });
}
