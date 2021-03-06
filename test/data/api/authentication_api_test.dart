import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';

import 'authentication_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  final _apiClient = MockApiClient();
  final _api = AuthenticationApiImpl(apiClient: _apiClient);

  tearDown(() {
    reset(_apiClient);
  });

  group('Testing the authentication API.', () {
    test('Basic testing authentication API.', () async {
      // stub生成
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _api(
        mobilePhoneNumber: '09012345678',
        authCode: 'dummy',
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

    test('Authentication API test using OS version.', () async {
      // stub生成
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _api(
        mobilePhoneNumber: '09012345678',
        authCode: 'dummy',
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

    test('Authentication API test using device name.', () async {
      // stub生成
      when(
        _apiClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => '');
      // test対象実行
      await _api(
        mobilePhoneNumber: '09012345678',
        authCode: 'dummy',
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

  group('Testing the pattern of authentication api errors.', () {
    test('Testing the pattern of authentication api exception error.',
        () async {
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
        () => _api(
          mobilePhoneNumber: '09012345678',
          authCode: 'dummy',
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
