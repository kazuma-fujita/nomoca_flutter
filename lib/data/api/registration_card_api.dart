import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class RegistrationCardApi {
  Future<void> call({
    required String authenticationToken,
    required int sourceUserId,
    int? familyUserId,
  });
}

class RegistrationCardApiImpl implements RegistrationCardApi {
  RegistrationCardApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<void> call({
    required String authenticationToken,
    required int sourceUserId,
    int? familyUserId,
  }) async {
    final body = {
      'source_id': sourceUserId,
      if (familyUserId != null) 'family_id': familyUserId,
    };
    await apiClient.post(
      '${NomocaApiEndpoints.patientCards}/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
      body: json.encode(body),
    );
  }
}
