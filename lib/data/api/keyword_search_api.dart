import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class KeywordSearchApi {
  Future<String> call({
    required String authenticationToken,
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  });
}

class KeywordSearchApiImpl implements KeywordSearchApi {
  KeywordSearchApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  }) async {
    var getQuery = 'q=$query&offset=$offset&limit=$limit';
    if (latitude != null && longitude != null) {
      getQuery += '&lat=$latitude&lng=$longitude';
    }
    final response = await apiClient.get(
      '${NomocaApiEndpoints.institution}/search/?$getQuery',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
