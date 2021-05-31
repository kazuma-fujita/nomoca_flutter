import 'package:nomoca_flutter/constants/environment_variables.dart';

class NomocaApiProperties {
  static const xApiKey = String.fromEnvironment('NOMOCA_X_API_KEY');
  static const baseUrl = String.fromEnvironment('NOMOCA_API_BASE_URL');
  static const apiVersion = 'v7';
  static const jwtPrefix = 'JWT';
  static const baseHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'X-API-Key': EnvironmentVariables.nomocaXApiKey,
  };
  static Map<String, String> authenticationTokenHeader(
      {required String authenticationToken}) {
    return {...baseHeaders, 'Authorization': authenticationToken};
  }
}
