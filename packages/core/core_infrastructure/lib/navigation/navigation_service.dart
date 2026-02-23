import 'package:go_router/go_router.dart';

/// Navigation service interface for type-safe navigation.
///
/// Wraps GoRouter to provide a clean API for navigation.
/// This abstraction allows for easier testing by enabling mocking.
///
/// ## Usage
///
/// Navigate to a route by path:
/// ```dart
/// navigationService.go('/home');
/// ```
///
/// Navigate to a named route:
/// ```dart
/// navigationService.goNamed('hiveDetail', pathParameters: {'id': '123'});
/// ```
///
/// Push a new route and get result:
/// ```dart
/// final result = await navigationService.push<String>('/dialog');
/// ```
///
/// ## Registration
///
/// This service must be registered manually in your app shell after
/// creating the GoRouter instance:
/// ```dart
/// final router = createAppRouter(routes: [...]);
/// getIt.registerSingleton<GoRouter>(router);
/// getIt.registerSingleton<NavigationService>(GoRouterNavigationService(router));
/// ```
abstract class NavigationService {
  /// Navigate to a route by path, replacing the current stack.
  ///
  /// This is equivalent to a browser location change.
  void go(String location);

  /// Push a new route onto the navigation stack.
  ///
  /// Allows the user to go back to the previous route.
  /// Returns a [Future] that completes with the result when the route is popped.
  Future<T?> push<T extends Object?>(String location);

  /// Pop the current route from the navigation stack.
  ///
  /// Optionally pass a [result] to return to the previous route.
  /// Returns to the previous route. If there's no route to pop,
  /// this is a no-op.
  void pop<T extends Object?>([T? result]);

  /// Whether the navigator can pop the current route.
  ///
  /// Returns true if there is a previous route to pop to.
  bool canPop();

  /// Replace the current route with a new one.
  ///
  /// The new route replaces the current route in the stack,
  /// so the user cannot go back to it.
  void replace(String location);

  /// Navigate to a named route with optional parameters.
  ///
  /// [name] is the route name defined in the router configuration.
  /// [pathParameters] are path parameters like `/hive/:id`.
  /// [queryParameters] are query parameters like `?filter=active`.
  /// [extra] is additional data to pass to the route.
  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  });

  /// Push a named route onto the navigation stack.
  ///
  /// Returns a [Future] that completes with the result when the route is popped.
  /// [name] is the route name defined in the router configuration.
  /// [pathParameters] are path parameters like `/hive/:id`.
  /// [queryParameters] are query parameters like `?filter=active`.
  /// [extra] is additional data to pass to the route.
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  });

  /// Replace the current route with a named route.
  ///
  /// [name] is the route name defined in the router configuration.
  /// [pathParameters] are path parameters like `/hive/:id`.
  /// [queryParameters] are query parameters like `?filter=active`.
  /// [extra] is additional data to pass to the route.
  void replaceNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  });
}

/// Implementation of [NavigationService] that wraps GoRouter.
///
/// **Important:** This service is NOT auto-registered via Injectable because
/// it depends on GoRouter which must be configured with routes first.
/// Register manually in your app shell:
///
/// ```dart
/// final router = createAppRouter(routes: myRoutes);
/// getIt.registerSingleton<GoRouter>(router);
/// getIt.registerSingleton<NavigationService>(GoRouterNavigationService(router));
/// ```
class GoRouterNavigationService implements NavigationService {
  /// Creates a navigation service that wraps the given [router].
  GoRouterNavigationService(this._router);

  final GoRouter _router;

  @override
  void go(String location) => _router.go(location);

  @override
  Future<T?> push<T extends Object?>(String location) => _router.push(location);

  @override
  void pop<T extends Object?>([T? result]) => _router.pop(result);

  @override
  bool canPop() => _router.canPop();

  @override
  void replace(String location) => _router.replace(location);

  @override
  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    return _router.pushNamed(
      name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  @override
  void replaceNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    _router.replaceNamed(
      name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }
}
