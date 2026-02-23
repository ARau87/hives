import 'package:core_infrastructure/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('NavigationService', () {
    test('GoRouterNavigationService implements NavigationService', () {
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (_, _) => const SizedBox()),
        ],
      );
      final service = GoRouterNavigationService(router);

      expect(service, isA<NavigationService>());
    });
  });

  group('GoRouterNavigationService', () {
    late GoRouter router;
    late GoRouterNavigationService navigationService;

    setUp(() {
      router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (_, _) => const Scaffold(body: Text('Home')),
          ),
          GoRoute(
            path: '/details',
            name: 'details',
            builder: (_, _) => const Scaffold(body: Text('Details')),
          ),
          GoRoute(
            path: '/item/:id',
            name: 'item',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return Scaffold(body: Text('Item $id'));
            },
          ),
        ],
      );
      navigationService = GoRouterNavigationService(router);
    });

    testWidgets('go navigates to location', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.text('Home'), findsOneWidget);

      navigationService.go('/details');
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
    });

    testWidgets('push adds route to stack', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.text('Home'), findsOneWidget);

      navigationService.push('/details');
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);

      // Pop should return to home
      navigationService.pop();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('pop returns to previous route', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      navigationService.push('/details');
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);

      navigationService.pop();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('replace replaces current route', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      navigationService.push('/details');
      await tester.pumpAndSettle();

      navigationService.replace('/item/123');
      await tester.pumpAndSettle();

      expect(find.text('Item 123'), findsOneWidget);

      // Pop should return to home (skipping details since it was replaced)
      navigationService.pop();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('goNamed navigates to named route', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      navigationService.goNamed('details');
      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
    });

    testWidgets('goNamed with path parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      navigationService.goNamed('item', pathParameters: {'id': '456'});
      await tester.pumpAndSettle();

      expect(find.text('Item 456'), findsOneWidget);
    });

    testWidgets('pushNamed adds named route to stack', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      navigationService.pushNamed('item', pathParameters: {'id': '789'});
      await tester.pumpAndSettle();

      expect(find.text('Item 789'), findsOneWidget);

      navigationService.pop();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });
  });
}
