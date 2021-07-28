import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/create_user_api.dart';
import 'package:nomoca_flutter/data/repository/create_user_repository.dart';

import 'create_user_repository_test.mocks.dart';

@GenerateMocks([CreateUserApi])
void main() {
  final _api = MockCreateUserApi();
  final _repository = CreateUserRepositoryImpl(createUserApi: _api);

  tearDown(() {
    reset(_api);
  });

  group('Testing the create user repository.', () {
    test('Testing call api of create user.', () async {
      // Create the stub.
      when(
        _api(
          mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
          nickname: anyNamed('nickname'),
          osVersion: anyNamed('osVersion'),
          deviceName: anyNamed('deviceName'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.createUser(
        mobilePhoneNumber: '09012345678',
        nickname: '太郎',
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        nickname: anyNamed('nickname'),
        osVersion: anyNamed('osVersion'),
        deviceName: anyNamed('deviceName'),
      ));
    });
  });

  group('Error testing of the create user repository.', () {
    test('Error testing for exception.', () async {
      // Create the stub.
      when(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        nickname: anyNamed('nickname'),
        osVersion: anyNamed('osVersion'),
        deviceName: anyNamed('deviceName'),
      )).thenThrow(Exception('Exception message.'));
      // Run the test method.
      expect(
        () => _repository.createUser(
          mobilePhoneNumber: '09012345678',
          nickname: '太郎',
        ),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        nickname: anyNamed('nickname'),
        osVersion: anyNamed('osVersion'),
        deviceName: anyNamed('deviceName'),
      ));
    });
  });
}
