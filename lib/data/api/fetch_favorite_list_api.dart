import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class FetchFavoriteListApi {
  Future<String> call({
    required String authenticationToken,
  });
}

class FetchFavoriteListApiImpl implements FetchFavoriteListApi {
  FetchFavoriteListApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({required String authenticationToken}) async {
    final response = await apiClient.get(
      '${NomocaApiEndpoints.favorites}/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
