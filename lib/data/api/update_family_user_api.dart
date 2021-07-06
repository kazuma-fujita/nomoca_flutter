import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateFamilyUserApi {
  Future<String> call({
    required String authenticationToken,
    required int familyUserId,
    required String nickname,
  });
}

class UpdateFamilyUserApiImpl implements UpdateFamilyUserApi {
  UpdateFamilyUserApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int familyUserId,
    required String nickname,
  }) async {
    final body = {
      'name': nickname,
    };
    final response = await apiClient.put(
      '${NomocaApiEndpoints.familyUsers}/$familyUserId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
      body: jsonEncode(body),
    );
    return response;
  }
}
