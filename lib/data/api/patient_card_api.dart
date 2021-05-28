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
  static const _endPoint = '/users/cards/';

  @override
  Future<String> get({required String authenticationToken}) async {
    final response = await apiClient.get(
      _endPoint,
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
