import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// Factory for creating the application's GoRouter instance.
///
/// This is a placeholder that will be configured in the app shell
/// with actual routes. The core_infrastructure package provides
/// the foundation, while the app shell defines the actual routing.
///
/// ## Usage
///
/// In the app shell:
/// ```dart
/// final router = createAppRouter(
///   routes: [
///     GoRoute(path: '/', builder: (_, __) => const HomePage()),
///     GoRoute(path: '/hives', builder: (_, __) => const HivesPage()),
///   ],
///   redirect: (context, state) {
///     // Auth redirect logic
///     return null;
///   },
/// );
/// ```
///
/// Then register in DI:
/// ```dart
/// getIt.registerSingleton<GoRouter>(router);
/// getIt.registerSingleton<NavigationService>(
///   GoRouterNavigationService(router),
/// );
/// ```
GoRouter createAppRouter({
  required List<RouteBase> routes,
  String initialLocation = '/',
  GoRouterRedirect? redirect,
  Listenable? refreshListenable,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: routes,
    redirect: redirect,
    refreshListenable: refreshListenable,
  );
}
