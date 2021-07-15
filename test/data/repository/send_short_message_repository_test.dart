import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/send_short_message_api.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';

import 'send_short_message_repository_test.mocks.dart';

@GenerateMocks([SendShortMessageApi])
void main() {
  final _api = MockSendShortMessageApi();
  final _repository = SendShortMessageRepositoryImpl(sendShortMessageApi: _api);

  tearDown(() {
    reset(_api);
  });

  group('Testing the send short message repository.', () {
    test('Testing call api of send short message.', () async {
      // Create the stub.
      when(
        _api(
          mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.sendShortMessage(
        mobilePhoneNumber: '09012345678',
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
      ));
    });
  });

  group('Error testing of the send short message repository.', () {
    test('Error testing for exception.', () async {
      // Create the stub.
      when(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
      )).thenThrow(Exception('Exception message.'));
      // Run the test method.
      expect(
        () => _repository.sendShortMessage(
          mobilePhoneNumber: '09012345678',
        ),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
      ));
    });
  });
}
