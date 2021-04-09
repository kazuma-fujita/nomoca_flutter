import 'package:nomoca_flutter/constants/environment_variables.dart';

class NomocaApiProperties {
  static const baseHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'X-API-Key': EnvironmentVariables.nomocaXApiKey,
  };
}
