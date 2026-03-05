import 'package:core_infrastructure/core_infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/config/flavors.dart';
import 'package:mobile/config/router.dart';

/// Shared bootstrap logic for all flavor entry points.
///
/// Initializes dependency injection, registers the router and
/// navigation service, then launches the app.
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = getConfig(environment);

  // Initialize auto-generated DI registrations (EventBus, etc.)
  configureInjection();

  // Register router and navigation service manually
  // (NavigationService depends on GoRouter which needs routes first)
  final router = appRouter();
  getIt.registerSingleton(router);
  getIt.registerSingleton<NavigationService>(
    GoRouterNavigationService(router),
  );

  // Store config for later access
  getIt.registerSingleton(config);

  runApp(const HivesApp());
}
