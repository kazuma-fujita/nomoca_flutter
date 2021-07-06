import 'package:nomoca_flutter/constants/nomoca_api_endpoints.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class PatientCardApi {
  Future<String> get({
    required String authenticationToken,
  });
}

class PatientCardApiImpl implements PatientCardApi {
  PatientCardApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> get({required String authenticationToken}) async {
    final response = await apiClient.get(
      '${NomocaApiEndpoints.patientCards}/',
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
