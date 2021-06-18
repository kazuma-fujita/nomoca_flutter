import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';

import '../../fixture.dart';
import 'update_user_repository_test.mocks.dart';

@GenerateMocks([UpdateUserApi, UserDao])
void main() {
  late MockUserDao _dao;
  late MockUpdateUserApi _api;
  late UpdateUserRepository _repository;

  setUp(() async {
    _dao = MockUserDao();
    _api = MockUpdateUserApi();
    _repository = UpdateUserRepositoryImpl(updateUserApi: _api, userDao: _dao);
  });

  group('Testing the update user repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_dao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(_dao.save(any)).thenAnswer((_) async => Future.value());
      when(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
        userId: anyNamed('userId'),
      )).thenAnswer((_) async => fixture('update_user.json'));
      // Run the test method.
      final entity = await _repository.updateUser(nickname: '花子', userId: 1372);
      // Validate the result objects.
      expect(
        entity,
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1372)
            .having((entity) => entity.nickname, 'nickname', '花子'),
      );
      // Validate the method call.
      verify(_dao.get());
      verify(_dao.save(any));
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
        userId: anyNamed('userId'),
      ));
    });
  });

  group('Error testing of the update user repository.', () {
    test('Verify error of authentication.', () async {
      // Create the stub.
      when(_dao.get()).thenReturn(null);
      // Run the test method.
      expect(
        _repository.updateUser(nickname: '花子', userId: 1372),
        throwsA(const TypeMatcher<AuthenticationError>()),
      );
      // Validate the method call.
      verify(_dao.get());
      verifyNever(_dao.save(any));
      verifyNever(_api());
    });

    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_dao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(_dao.save(any)).thenAnswer((_) async => Future.value());
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
          userId: anyNamed('userId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.updateUser(nickname: '花子', userId: 1372),
        throwsException,
      );
      // Validate the method call.
      verify(_dao.get());
      verifyNever(_dao.save(any));
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
        userId: anyNamed('userId'),
      ));
    });
  });
}
