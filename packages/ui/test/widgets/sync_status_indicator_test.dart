import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/src/components/feedback/sync_status_indicator.dart';
import 'package:ui/src/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('SyncStatusIndicator', () {
    Widget buildWidget(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

    // Label tests
    testWidgets('offline state renders Offline label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.offline),
      ));
      expect(find.text('Offline'), findsOneWidget);
    });

    testWidgets('syncing state renders Syncing... label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.syncing),
      ));
      expect(find.text('Syncing...'), findsOneWidget);
    });

    testWidgets('synced state renders Synced label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.synced),
      ));
      expect(find.text('Synced'), findsOneWidget);
    });

    testWidgets('error state renders Sync Error label', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.error),
      ));
      expect(find.text('Sync Error'), findsOneWidget);
    });

    // Icon tests
    testWidgets('offline state renders cloud_off icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.offline),
      ));
      expect(find.byIcon(Icons.cloud_off), findsOneWidget);
    });

    testWidgets('syncing state renders sync icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.syncing),
      ));
      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('synced state renders cloud_done icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.synced),
      ));
      expect(find.byIcon(Icons.cloud_done), findsOneWidget);
    });

    testWidgets('error state renders sync_problem icon', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.error),
      ));
      expect(find.byIcon(Icons.sync_problem), findsOneWidget);
    });

    // Structure test
    testWidgets('renders Row with icon and text', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.synced),
      ));
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    // Dark mode
    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(buildWidget(
        const SyncStatusIndicator(state: SyncState.synced),
        theme: AppTheme.darkTheme,
      ));
      expect(find.text('Synced'), findsOneWidget);
    });

    testWidgets('all states render without throwing', (tester) async {
      for (final state in SyncState.values) {
        await tester.pumpWidget(buildWidget(SyncStatusIndicator(state: state)));
        expect(find.byType(SyncStatusIndicator), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });
  });
}
