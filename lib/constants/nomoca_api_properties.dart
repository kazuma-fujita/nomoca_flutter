import 'package:nomoca_flutter/constants/environment_variables.dart';

class NomocaApiProperties {
  static const baseHeaders = <String, String>{
    'content-type': 'application/json',
    'x-api-key': EnvironmentVariables.nomocaXApiKey,
  };
}
