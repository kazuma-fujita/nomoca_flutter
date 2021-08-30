import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class AuthenticationApi {
  Future<String> call({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  });
}

class AuthenticationApiImpl implements AuthenticationApi {
  AuthenticationApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String mobilePhoneNumber,
    required String authCode,
    String? osVersion,
    String? deviceName,
  }) async {
    final body = {
      'mobile_tel': mobilePhoneNumber,
      'auth_code': authCode,
      if (osVersion != null) 'os_version': osVersion,
      if (deviceName != null) 'device_name': deviceName,
    };
    final response = await apiClient.post(
      '${NomocaApiEndpoints.users}/authentication/',
      headers: NomocaApiProperties.baseHeaders,
      body: json.encode(body),
    );
    return response;
  }
}
