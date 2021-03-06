import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import '../../fixture.dart';
import 'fetch_family_user_list_repository_test.mocks.dart';

@GenerateMocks([FetchFamilyUserListApi, UserDao])
void main() {
  late MockFetchFamilyUserListApi _api;
  late FetchFamilyUserListRepository _repository;
  late MockUserDao _userDao;

  setUp(() async {
    _api = MockFetchFamilyUserListApi();
    _userDao = MockUserDao();
    _repository = FetchFamilyUserListRepositoryImpl(
        fetchFamilyUserListApi: _api, userDao: _userDao);
  });

  group('Testing the fetch family user list repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('family_user_list.json'));
      // Run the test method.
      final patientCardList = await _repository.fetchList();
      // Validate the result objects.
      expect(
        patientCardList,
        [
          isA<UserNicknameEntity>()
              .having((entity) => entity.id, 'id', 1372)
              .having((entity) => entity.nickname, 'nickname', '花子'),
          isA<UserNicknameEntity>()
              .having((entity) => entity.id, 'id', 1373)
              .having((entity) => entity.nickname, 'nickname', '次郎')
        ],
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });

  group('Error testing of the fetch family user list repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.fetchList(),
        throwsException,
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });
}
