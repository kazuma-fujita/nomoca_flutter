import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';

// ignore: one_member_abstracts
abstract class FetchNotificationListApi {
  Future<String> call({
    required String authenticationToken,
  });
}

class FetchNotificationListApiImpl implements FetchNotificationListApi {
  FetchNotificationListApiImpl({required this.apiClient});

  final ApiClient apiClient;
  static const _endPoint = '/users/notifies/';

  @override
  Future<String> call({required String authenticationToken}) async {
    final response = await apiClient.get(
      _endPoint,
      headers: NomocaApiProperties.authenticationTokenHeader(
          authenticationToken: authenticationToken),
    );
    return response;
  }
}
