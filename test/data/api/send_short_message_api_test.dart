import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/send_short_message_api.dart';
import 'send_short_message_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  final _apiClient = MockApiClient();
  final _api = SendShortMessageApiImpl(apiClient: _apiClient);

  tearDown(() {
    reset(_apiClient);
  });

  group('Testing the send short message API.', () {
    test('Basic testing send short message API.', () async {
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

  group('Testing the pattern of send short message api errors.', () {
    test('Testing the pattern of send short message api exception error.',
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
