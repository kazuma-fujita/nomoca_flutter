import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class FetchPreviewCardsApi {
  Future<String> call({
    required String authenticationToken,
    required String userToken,
    int? familyUserId,
  });
}

class FetchPreviewCardsApiImpl implements FetchPreviewCardsApi {
  FetchPreviewCardsApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required String userToken,
    int? familyUserId,
  }) async {
    var getQuery = 'user_token=$userToken';
    if (familyUserId != null) {
      getQuery += '&family_id=$familyUserId';
    }
    final response = await apiClient.get(
      '${NomocaApiEndpoints.patientCards}/preview/?$getQuery',
      headers: NomocaApiProperties.authenticationTokenHeader(
        authenticationToken: authenticationToken,
      ),
    );
    return response;
  }
}
