import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class UpdateFavoriteApi {
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
  });
}

class UpdateFavoriteApiImpl implements UpdateFavoriteApi {
  UpdateFavoriteApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int userId,
    required int institutionId,
  }) async {
    final response = await apiClient.put(
      '${NomocaApiEndpoints.favorites}/end_users/$userId/institutions/$institutionId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
