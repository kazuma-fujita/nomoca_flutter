import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';

import 'authentication_repository_test.mocks.dart';

@GenerateMocks([AuthenticationApi])
void main() {
  final _api = MockAuthenticationApi();
  final _repository = AuthenticationRepositoryImpl(authenticationApi: _api);

  tearDown(() {
    reset(_api);
  });

  group('Testing the authentication repository.', () {
    test('Testing call api of authentication.', () async {
      // Create the stub.
      when(
        _api(
          mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
          authCode: anyNamed('authCode'),
          deviceName: anyNamed('deviceName'),
          osVersion: anyNamed('osVersion'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.authentication(
        mobilePhoneNumber: '09012345678',
        authCode: 'dummy',
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        authCode: anyNamed('authCode'),
        deviceName: anyNamed('deviceName'),
        osVersion: anyNamed('osVersion'),
      ));
    });
  });

  group('Error testing of the authentication repository.', () {
    test('Error testing for exception.', () async {
      // Create the stub.
      when(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        authCode: anyNamed('authCode'),
        deviceName: anyNamed('deviceName'),
        osVersion: anyNamed('osVersion'),
      )).thenThrow(Exception('Exception message.'));
      // Run the test method.
      expect(
        () => _repository.authentication(
          mobilePhoneNumber: '09012345678',
          authCode: 'dummy',
        ),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        authCode: anyNamed('authCode'),
        deviceName: anyNamed('deviceName'),
        osVersion: anyNamed('osVersion'),
      ));
    });
  });
}
