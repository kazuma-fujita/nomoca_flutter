import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateNotificationTokenApi {
  Future<void> call({
    required String authenticationToken,
    required String notificationToken,
  });
}

class UpdateNotificationTokenApiImpl implements UpdateNotificationTokenApi {
  UpdateNotificationTokenApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<void> call({
    required String authenticationToken,
    required String notificationToken,
  }) async {
    await apiClient.put(
      '${NomocaApiEndpoints.notifications}/token/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
  }
}
