import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:authentication/authentication.dart';
import 'package:core_infrastructure/core_infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  // Register Cognito authentication services
  final userPool = CognitoUserPool(
    config.cognitoUserPoolId,
    config.cognitoClientId,
  );
  getIt.registerSingleton<CognitoUserPool>(userPool);
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => CognitoDataSource(userPool: getIt<CognitoUserPool>()),
  );

  // Register local auth storage and repository
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => SecureStorageAuthLocalDataSource(
      secureStorage: const FlutterSecureStorage(),
    ),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
      eventBus: getIt<EventBus>(),
    ),
  );

  runApp(const HivesApp());
}
