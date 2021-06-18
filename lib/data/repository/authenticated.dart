import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

mixin Authenticated {
  String getAuthenticationToken(User? user) {
    if (user == null || user.authenticationToken == null) {
      throw AuthenticationError();
    }
    return '${NomocaApiProperties.jwtPrefix} ${user.authenticationToken}';
  }
}
