import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ApiClient _apiClient;
  late AuthenticationApi _authenticationApi;

  setUp(() async {
    // _apiClient = MockApiClient();
    _apiClient = ApiClientImpl(baseUrl: 'http://192.168.0.10:8000');
    _authenticationApi = AuthenticationApiImpl(apiClient: _apiClient);
  });

  group('Testing the authentication api testing.', () {
    test('Testing the sign up api.', () async {
      // when(_apiClient.post('',
      //         headers: {
      //           'content-type': 'application/json',
      //           'x-api-key': '',
      //         },
      //         body: '{ "mobile_tel": "", "name": "" }'))
      //     .thenAnswer(
      //         (_) async => Future.value('{ "mobile_tel": "", "name": "" }'));
      await _authenticationApi.signUp(
          mobilePhoneNumber: '09011112223', nickname: 'fafafa');
      // verify(_apiClient.post(
      //   '/users/',
      //   headers: {
      //     'content-type': 'application/json',
      //     'x-api-key': '',
      //   },
      //   body: '{ "mobile_tel": "", "name": "" }',
      // )).called(1);
    });
  });
}
