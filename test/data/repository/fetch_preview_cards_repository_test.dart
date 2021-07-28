import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/fetch_preview_cards_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_preview_cards_repository.dart';

import '../../fixture.dart';
import 'fetch_preview_cards_repository_test.mocks.dart';

@GenerateMocks([FetchPreviewCardsApi, UserDao])
void main() {
  final _api = MockFetchPreviewCardsApi();
  final _userDao = MockUserDao();
  final _repository = FetchPreviewCardsRepositoryImpl(
      fetchPreviewCardsApi: _api, userDao: _userDao);

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the get fetch preview cards repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userToken: anyNamed('userToken'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenAnswer((_) async => fixture('preview_cards.json'));
      // Run the test method.
      final entity =
          await _repository.fetchCards(userToken: 'dummy', familyUserId: 123);
      // Validate the result objects.
      expect(
        entity,
        isA<PreviewCardsEntity>()
            .having((entity) => entity.sourceUserId, 'id', 275)
            .having((entity) => entity.patients.length, 'length', 2)
            .having(
                (entity) => entity.patients[0].nameKana, 'nameKana', 'ｻﾄｳ ﾀﾛｳ')
            .having(
                (entity) => entity.patients[0].localId, 'localId', '1234567890')
            .having((entity) => entity.patients[0].institution.institutionId,
                'institutionId', 185)
            .having((entity) => entity.patients[0].institution.institutionName,
                'institutionName', 'こころデンタルクリニック')
            .having(
                (entity) => entity.patients[1].nameKana, 'nameKana', 'ｻﾄｳ ﾀﾛｳ')
            .having((entity) => entity.patients[1].localId, 'localId',
                '987654321098765432')
            .having((entity) => entity.patients[1].institution.institutionId,
                'institutionId', 252765)
            .having((entity) => entity.patients[1].institution.institutionName,
                'institutionName', '上田矯正歯科'),
      );
      // Validate the method call.
      verify(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userToken: anyNamed('userToken'),
          familyUserId: anyNamed('familyUserId'),
        ),
      );
      verify(_userDao.get());
    });
  });

  group('Error testing of the fetch preview cards repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userToken: anyNamed('userToken'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.fetchCards(userToken: 'dummy', familyUserId: 1234),
        throwsException,
      );
      // Validate the method call.
      verify(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userToken: anyNamed('userToken'),
          familyUserId: anyNamed('familyUserId'),
        ),
      );
      verify(_userDao.get());
    });
  });
}
