import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class SendShortMessageApi {
  Future<void> call({
    required String mobilePhoneNumber,
  });
}

class SendShortMessageApiImpl implements SendShortMessageApi {
  SendShortMessageApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<void> call({
    required String mobilePhoneNumber,
  }) async {
    final body = {
      'mobile_tel': mobilePhoneNumber,
    };
    await apiClient.post(
      '${NomocaApiEndpoints.users}/short_message/',
      headers: NomocaApiProperties.baseHeaders,
      body: json.encode(body),
    );
  }
}
