import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import '../../fixture.dart';
import 'create_family_user_repository_test.mocks.dart';

@GenerateMocks([CreateFamilyUserApi, UserDao])
void main() {
  late MockCreateFamilyUserApi _api;
  late CreateFamilyUserRepository _repository;
  late MockUserDao _userDao;

  setUp(() async {
    _api = MockCreateFamilyUserApi();
    _userDao = MockUserDao();
    _repository = CreateFamilyUserRepositoryImpl(
        createFamilyUserApi: _api, userDao: _userDao);
  });

  group('Testing the create family user repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
        ),
      ).thenAnswer((_) async => fixture('create_family_user.json'));
      // Run the test method.
      final entity = await _repository.createUser(nickname: '花子');
      // Validate the result objects.
      expect(
        entity,
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1372)
            .having((entity) => entity.nickname, 'nickname', '花子'),
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
      ));
      verify(_userDao.get());
    });
  });

  group('Error testing of the create family user repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.createUser(nickname: '花子'),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
      ));
      verify(_userDao.get());
    });
  });
}
