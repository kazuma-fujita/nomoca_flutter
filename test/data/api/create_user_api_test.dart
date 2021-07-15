import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/create_user_api.dart';

import 'create_user_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  final _apiClient = MockApiClient();
  final _api = CreateUserApiImpl(apiClient: _apiClient);

  tearDown(() {
    reset(_apiClient);
  });

  group('Testing the create user API.', () {
    test('Basic testing create user API.', () async {
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

    test('Create user API test using OS version.', () async {
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

    test('Create user API test using device name.', () async {
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

  group('Testing the pattern of create user api errors.', () {
    test('Testing the pattern of create user api exception error.', () async {
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
