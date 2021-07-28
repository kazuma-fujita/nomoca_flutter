import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/registration_card_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';

import '../../fixture.dart';
import 'registration_card_repository_test.mocks.dart';

@GenerateMocks([RegistrationCardApi, UserDao])
void main() {
  final _api = MockRegistrationCardApi();
  final _userDao = MockUserDao();
  final _repository = RegistrationCardRepositoryImpl(
      registrationCardApi: _api, userDao: _userDao);

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the registration card repository.', () {
    test('Testing call of registration card api.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          sourceUserId: anyNamed('sourceUserId'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Run the test method.
      await _repository.registration(sourceUserId: 1234, familyUserId: 9876);
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      ));
      verify(_userDao.get());
    });
  });

  group('Error testing of the registration card repository.', () {
    test('Error testing for exception.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          sourceUserId: anyNamed('sourceUserId'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenThrow(Exception('Exception message.'));
      // Run the test method.
      expect(
        () => _repository.registration(sourceUserId: 1234, familyUserId: 9876),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      ));
      verify(_userDao.get());
    });
  });
}
