import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateNextReserveDateApi {
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
    required String reserveDate,
  });
}

class UpdateNextReserveDateApiImpl implements UpdateNextReserveDateApi {
  UpdateNextReserveDateApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
    required String reserveDate,
  }) async {
    final body = {
      'reserve_at': reserveDate,
    };
    final response = await apiClient.put(
      '${NomocaApiEndpoints.reserves}/$userId/$institutionId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
      body: json.encode(body),
    );
    return response;
  }
}
