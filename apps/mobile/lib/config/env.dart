/// Application environment configuration.
enum AppEnvironment {
  dev,
  staging,
  production,
}

/// Environment-specific configuration values.
class EnvConfig {
  const EnvConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
  });

  final AppEnvironment environment;
  final String appName;
  final String apiBaseUrl;

  bool get isDev => environment == AppEnvironment.dev;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProduction => environment == AppEnvironment.production;
}
