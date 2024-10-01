class Config {
  const Config();

  /// The Sentry DSN.
  static String get sentryDsn => const String.fromEnvironment('SENTRY_DSN');

  /// The Base URL
  static String get apiBaseUrl => const String.fromEnvironment('BASE_URL');
}
