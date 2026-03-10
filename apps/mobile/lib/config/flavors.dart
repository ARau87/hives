import 'package:mobile/config/env.dart';

/// Factory for creating environment-specific configurations.
EnvConfig getConfig(AppEnvironment environment) {
  switch (environment) {
    // TODO(security): Cognito pool IDs and client IDs should be injected via
    // --dart-define at build time rather than hardcoded here. Use:
    //   flutter run --dart-define=COGNITO_POOL_ID=... --dart-define=COGNITO_CLIENT_ID=...
    // and read with: const String.fromEnvironment('COGNITO_POOL_ID')
    case AppEnvironment.dev:
      return const EnvConfig(
        environment: AppEnvironment.dev,
        appName: 'Hives Dev',
        apiBaseUrl: 'https://api-dev.example.com',
        cognitoUserPoolId: 'eu-central-1_gwBNy2H8l',
        cognitoClientId: '5u9hrem2ap49rhga4mom4lrloe',
      );
    case AppEnvironment.staging:
      return const EnvConfig(
        environment: AppEnvironment.staging,
        appName: 'Hives Staging',
        apiBaseUrl: 'https://api-staging.example.com',
        cognitoUserPoolId: 'eu-central-1_StagingPoolId',
        cognitoClientId: 'staging-client-id-placeholder',
      );
    case AppEnvironment.production:
      return const EnvConfig(
        environment: AppEnvironment.production,
        appName: 'Hives',
        apiBaseUrl: 'https://api.example.com',
        cognitoUserPoolId: 'eu-central-1_ProdPoolId',
        cognitoClientId: 'prod-client-id-placeholder',
      );
  }
}
