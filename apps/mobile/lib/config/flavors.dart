import 'package:mobile/config/env.dart';

/// Factory for creating environment-specific configurations.
EnvConfig getConfig(AppEnvironment environment) {
  switch (environment) {
    case AppEnvironment.dev:
      return const EnvConfig(
        environment: AppEnvironment.dev,
        appName: 'Hives Dev',
        apiBaseUrl: 'https://api-dev.example.com',
      );
    case AppEnvironment.staging:
      return const EnvConfig(
        environment: AppEnvironment.staging,
        appName: 'Hives Staging',
        apiBaseUrl: 'https://api-staging.example.com',
      );
    case AppEnvironment.production:
      return const EnvConfig(
        environment: AppEnvironment.production,
        appName: 'Hives',
        apiBaseUrl: 'https://api.example.com',
      );
  }
}
