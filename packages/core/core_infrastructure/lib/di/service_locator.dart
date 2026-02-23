import 'package:get_it/get_it.dart';

/// The global service locator instance.
///
/// Use this instance to access registered services throughout the app.
///
/// ## Usage
///
/// Retrieving services:
/// ```dart
/// final eventBus = getIt<EventBus>();
/// ```
///
/// This instance is configured via [configureInjection] which should be
/// called once during app startup.
final GetIt getIt = GetIt.instance;
