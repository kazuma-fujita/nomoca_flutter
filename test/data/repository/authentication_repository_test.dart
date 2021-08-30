import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/authentication_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

import '../../fixture.dart';
import 'authentication_repository_test.mocks.dart';

@GenerateMocks([AuthenticationApi, UserDao])
void main() {
  final _api = MockAuthenticationApi();
  final _userDao = MockUserDao();
  final _repository =
      AuthenticationRepositoryImpl(authenticationApi: _api, userDao: _userDao);

  tearDown(() {
    reset(_api);
    reset(_userDao);
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
      ).thenAnswer((_) async => fixture('authentication.json'));
      when(_userDao.get()).thenReturn(User()..fcmToken = 'dummyFcmToken');
      // Run the test method.
      final entity = await _repository.authentication(
        mobilePhoneNumber: '09012345678',
        authCode: 'dummy',
      );
      expect(
          entity,
          isA<AuthenticationEntity>()
              .having((entity) => entity.authenticationToken, 'token',
                  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJ1c2VybmFtZSI6ImN1c3RvbWVyMkBub21vY2EuY29tIiwiZXhwIjoxNTE4NzY1NDY3LCJlbWFpbCI6ImN1c3RvbWVyMkBub21vY2EuY29tIn0.VvR')
              .having((entity) => entity.nickname, 'nickname', '太郎')
              .having((entity) => entity.userId, 'userId', 199));
      // Validate the method call.
      verify(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        authCode: anyNamed('authCode'),
        deviceName: anyNamed('deviceName'),
        osVersion: anyNamed('osVersion'),
      ));
      verify(_userDao.get());
      verify(_userDao.save(any));
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
      when(_userDao.get()).thenReturn(User()..fcmToken = 'dummyFcmToken');
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
      verify(_userDao.get());
      verifyNever(_userDao.save(any));
    });

    test('Testing that user data is not found from database.', () async {
      // Create the stub.
      when(
        _api(
          mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
          authCode: anyNamed('authCode'),
          deviceName: anyNamed('deviceName'),
          osVersion: anyNamed('osVersion'),
        ),
      ).thenAnswer((_) async => fixture('authentication.json'));
      when(_userDao.get()).thenReturn(null);
      // Run the test method.
      expect(
        () => _repository.authentication(
          mobilePhoneNumber: '09012345678',
          authCode: 'dummy',
        ),
        throwsA(const TypeMatcher<AuthenticationError>()),
      );
      // Validate the method call.
      verifyNever(_api(
        mobilePhoneNumber: anyNamed('mobilePhoneNumber'),
        authCode: anyNamed('authCode'),
        deviceName: anyNamed('deviceName'),
        osVersion: anyNamed('osVersion'),
      ));
      verify(_userDao.get());
      verifyNever(_userDao.save(any));
    });
  });
}
