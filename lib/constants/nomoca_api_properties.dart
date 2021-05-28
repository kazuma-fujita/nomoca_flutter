import 'package:nomoca_flutter/constants/environment_variables.dart';

class NomocaApiProperties {
  static const baseHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'X-API-Key': EnvironmentVariables.nomocaXApiKey,
  };
  static const apiVersion = 'v7';
  static Map<String, String> authenticationTokenHeader(
      {required String authenticationToken}) {
    return {...baseHeaders, 'Authorization': authenticationToken};
  }
}
