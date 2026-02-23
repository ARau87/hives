import 'package:core_infrastructure/di/injection.config.dart';
import 'package:core_infrastructure/di/service_locator.dart';
import 'package:injectable/injectable.dart';

/// Configures dependency injection for the application.
///
/// This function should be called once during app startup, before
/// any services are accessed.
///
/// ## Usage
///
/// In your main.dart:
/// ```dart
/// void main() {
///   configureInjection();
///   runApp(const App());
/// }
/// ```
///
/// After configuration, services can be accessed via [getIt]:
/// ```dart
/// final eventBus = getIt<EventBus>();
/// ```
@InjectableInit(initializerName: 'init')
void configureInjection() => getIt.init();
