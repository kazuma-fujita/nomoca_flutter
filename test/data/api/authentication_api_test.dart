import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'authentication_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient _apiClient;
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
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      );
    });

    test('Sign up API test using OS version.', () async {
      // stub生成
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
        osVersion: '14.4.2',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      );
    });

    test('Sign up API test using device name.', () async {
      // stub生成
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _authenticationApi.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
        deviceName: 'iPhone13,2',
      );
      // method呼び出し検証
      verify(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      );
    });
  });

  group('Testing the pattern of authentication API errors.', () {
    test('Testing the pattern of sign up API error.', () async {
      // Create the stub.
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(Exception('Exception message.'));
      // Run the test method.
      expect(
        () => _authenticationApi.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
        throwsException,
      );
      // Validate the method call.
      verify(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      );
    });
  });
}
