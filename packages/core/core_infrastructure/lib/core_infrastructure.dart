/// Core infrastructure for the Hives project.
///
/// This package provides:
/// - Event bus for inter-module communication
/// - Dependency injection setup (GetIt/Injectable)
/// - Navigation service
///
/// ## Getting Started
///
/// Configure dependency injection during app startup:
/// ```dart
/// import 'package:core_infrastructure/core_infrastructure.dart';
///
/// void main() {
///   configureInjection();
///   runApp(const App());
/// }
/// ```
///
/// ## Event Bus
///
/// Publish and subscribe to domain events:
/// ```dart
/// final eventBus = getIt<EventBus>();
///
/// // Subscribe
/// eventBus.on<MyEvent>().listen((event) {
///   print('Received: $event');
/// });
///
/// // Publish
/// eventBus.publish(MyEvent(aggregateId: '123'));
/// ```
///
/// ## Navigation
///
/// Use the NavigationService for type-safe navigation:
/// ```dart
/// final nav = getIt<NavigationService>();
/// nav.go('/home');
/// nav.goNamed('hiveDetail', pathParameters: {'id': '123'});
/// ```
library;

// Event Bus
export 'package:core_infrastructure/event_bus/event_bus.dart';

// Dependency Injection
export 'package:core_infrastructure/di/service_locator.dart';
export 'package:core_infrastructure/di/injection.dart';

// Navigation
export 'package:core_infrastructure/navigation/navigation_service.dart';
export 'package:core_infrastructure/navigation/app_router.dart';
