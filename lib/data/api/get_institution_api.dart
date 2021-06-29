import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class GetInstitutionApi {
  Future<String> call({
    required String authenticationToken,
    required int institutionId,
  });
}

class GetInstitutionApiImpl implements GetInstitutionApi {
  GetInstitutionApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call({
    required String authenticationToken,
    required int institutionId,
  }) async {
    final response = await apiClient.get(
      '${NomocaApiEndpoints.institution}/$institutionId/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
