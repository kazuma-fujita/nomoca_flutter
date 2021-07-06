import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class DeleteFamilyUserApi {
  Future<String> call({
    required String authenticationToken,
    required int familyUserId,
  });
}

class DeleteFamilyUserApiImpl implements DeleteFamilyUserApi {
  DeleteFamilyUserApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int familyUserId,
  }) async {
    final response = await apiClient.delete(
      '${NomocaApiEndpoints.familyUsers}/$familyUserId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
