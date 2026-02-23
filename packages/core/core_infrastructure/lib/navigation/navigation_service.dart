import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

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
/// Push a new route:
/// ```dart
/// navigationService.push('/inspections/new');
/// ```
abstract class NavigationService {
  /// Navigate to a route by path, replacing the current stack.
  ///
  /// This is equivalent to a browser location change.
  void go(String location);

  /// Push a new route onto the navigation stack.
  ///
  /// Allows the user to go back to the previous route.
  void push(String location);

  /// Pop the current route from the navigation stack.
  ///
  /// Returns to the previous route. If there's no route to pop,
  /// this is a no-op.
  void pop();

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
  /// [name] is the route name defined in the router configuration.
  /// [pathParameters] are path parameters like `/hive/:id`.
  /// [queryParameters] are query parameters like `?filter=active`.
  /// [extra] is additional data to pass to the route.
  void pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  });
}

/// Implementation of [NavigationService] that wraps GoRouter.
///
/// This service is registered as a singleton in the DI container.
/// The GoRouter instance is provided during registration.
@Singleton(as: NavigationService)
class GoRouterNavigationService implements NavigationService {
  /// Creates a navigation service that wraps the given [router].
  GoRouterNavigationService(this._router);

  final GoRouter _router;

  @override
  void go(String location) => _router.go(location);

  @override
  void push(String location) => _router.push(location);

  @override
  void pop() => _router.pop();

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
  void pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    _router.pushNamed(
      name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }
}
