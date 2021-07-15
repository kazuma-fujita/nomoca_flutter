import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class CreateUserApi {
  Future<void> call({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  });
}

class CreateUserApiImpl implements CreateUserApi {
  CreateUserApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<void> call({
    required String mobilePhoneNumber,
    required String nickname,
    String? osVersion,
    String? deviceName,
  }) async {
    final body = {
      'mobile_tel': mobilePhoneNumber,
      'name': nickname,
      if (osVersion != null) 'os_version': osVersion,
      if (deviceName != null) 'device_name': deviceName,
    };
    await apiClient.post(
      '${NomocaApiEndpoints.users}/',
      headers: NomocaApiProperties.baseHeaders,
      body: json.encode(body),
    );
  }
}
