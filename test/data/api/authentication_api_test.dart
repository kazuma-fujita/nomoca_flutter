import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';

import 'authentication_api_test.mocks.dart';

// class MockApiClient extends Mock implements ApiClient {}

@GenerateMocks([ApiClient])
void main() {
  late ApiClient _apiClient;
  late AuthenticationApi _authenticationApi;

  setUp(() async {
    _apiClient = MockApiClient();
    _authenticationApi = AuthenticationApiImpl(apiClient: _apiClient);
  });

  group('Testing the authentication API.', () {
    test('Testing the basic sign up API.', () async {
      // stub生成
      when(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body: '{"mobile_tel":"09012345678","name":"test-user"}',
        ),
      ).thenAnswer((_) async => '{ "dummy_response": "dummy text"}');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body: '{"mobile_tel":"09012345678","name":"test-user"}',
        ),
      );
    });
    // OS Versionが
    test('Sign up API test using OS version.', () async {
      // stub生成
      when(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body:
              '{"mobile_tel":"09012345678","name":"test-user","os_version":"14.4.2"}',
        ),
      ).thenAnswer((_) async => '{ "dummy_response": "dummy text"}');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
        osVersion: '14.4.2',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body:
              '{"mobile_tel":"09012345678","name":"test-user","os_version":"14.4.2"}',
        ),
      );
    });
    test('Sign up API test using device name.', () async {
      // stub生成
      when(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body:
              '{"mobile_tel":"09012345678","name":"test-user","device_name":"iPhone13,2"}',
        ),
      ).thenAnswer((_) async => '{ "dummy_response": "dummy text"}');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
        deviceName: 'iPhone13,2',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body:
              '{"mobile_tel":"09012345678","name":"test-user","device_name":"iPhone13,2"}',
        ),
      );
    });
  });

  group('Testing the pattern of authentication API errors.', () {
    test('Testing the pattern of sign up API error.', () async {
      // stub生成
      when(
        _apiClient.post(
          '/users/',
          headers: NomocaApiProperties.baseHeaders,
          body: '{"mobile_tel":"09012345678","name":"test-user"}',
        ),
      ).thenThrow(Exception('error message'));
      // test対象実行
      expect(
        () => _authenticationApi.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
        throwsException,
      );
    });
  });
}
