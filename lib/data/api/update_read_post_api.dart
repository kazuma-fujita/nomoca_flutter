import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateReadPostApi {
  Future<String> call({
    required String authenticationToken,
    required int notificationId,
  });
}

class UpdateReadPostApiImpl implements UpdateReadPostApi {
  UpdateReadPostApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int notificationId,
  }) async {
    final response = await apiClient.put(
      '${NomocaApiEndpoints.notification}/read/$notificationId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
