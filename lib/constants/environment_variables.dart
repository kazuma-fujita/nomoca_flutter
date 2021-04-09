class EnvironmentVariables {
  static const environment = String.fromEnvironment('BUILD_ENV');
  static const nomocaApiBaseUrl = String.fromEnvironment('NOMOCA_API_BASE_URL');
  static const nomocaXApiKey = String.fromEnvironment('NOMOCA_X_API_KEY');
}
