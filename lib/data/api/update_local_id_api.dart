import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateLocalIdApi {
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
    required String localId,
  });
}

class UpdateLocalIdApiImpl implements UpdateLocalIdApi {
  UpdateLocalIdApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
    required String localId,
  }) async {
    final body = {
      'local_id': localId,
    };
    final response = await apiClient.put(
      '${NomocaApiEndpoints.localIds}/end_users/$userId/institutions/$institutionId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
      body: json.encode(body),
    );
    return response;
  }
}
