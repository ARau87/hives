import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/shell/app_shell_scaffold.dart';

/// Builds a minimal [GoRouter] that exercises [AppShellScaffold] directly,
/// with no [HivesApp] or GetIt involvement.
GoRouter _buildIsolatedRouter() {
  return GoRouter(
    initialLocation: '/a',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            AppShellScaffold(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/a', builder: (_, __) => const Text('Branch A')),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/b', builder: (_, __) => const Text('Branch B')),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/c', builder: (_, __) => const Text('Branch C')),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/d', builder: (_, __) => const Text('Branch D')),
          ]),
        ],
      ),
    ],
  );
}

void main() {
  testWidgets('AppShellScaffold renders NavigationBar with 4 destinations',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });

  testWidgets('AppShellScaffold shows correct navigation labels',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    // Each label appears exactly once — branch content uses 'Branch X', not
    // the tab names, so there is no ambiguity.
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Locations'), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Tapping Locations tab switches to branch 1', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.location_on_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Branch B'), findsOneWidget);
  });

  testWidgets('Tapping Tasks tab switches to branch 2', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.checklist_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Branch C'), findsOneWidget);
  });

  testWidgets('Tapping Settings tab switches to branch 3', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Branch D'), findsOneWidget);
  });

  testWidgets('Tapping Home tab returns to branch 0 from another tab',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(routerConfig: _buildIsolatedRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Branch A'), findsOneWidget);
  });
}
