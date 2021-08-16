import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class GetVersionApi {
  Future<String> call();
}

class GetVersionApiImpl implements GetVersionApi {
  GetVersionApiImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<String> call() async {
    final response = await apiClient.get(
      '/versions/',
      headers: NomocaApiProperties.baseHeaders,
    );
    return response;
  }
}
