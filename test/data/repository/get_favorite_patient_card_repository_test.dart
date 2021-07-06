import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/get_favorite_patient_card_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';

import '../../fixture.dart';
import 'get_favorite_patient_card_repository_test.mocks.dart';

@GenerateMocks([GetFavoritePatientCardApi, UserDao])
void main() {
  final _api = MockGetFavoritePatientCardApi();
  final _userDao = MockUserDao();
  final _repository = GetFavoritePatientCardRepositoryImpl(
    getFavoritePatientCardApi: _api,
    userDao: _userDao,
  );

  tearDown(() {
    reset(_api);
    reset(_userDao);
  });

  group('Testing the get favorite patient card repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userId: anyNamed('userId'),
          institutionId: anyNamed('institutionId'),
        ),
      ).thenAnswer((_) async => fixture('favorite_patient_card.json'));
      // Run the test method.
      final entity = await _repository.get(userId: 199, institutionId: 92506);
      // Validate the result objects.
      expect(
        entity,
        isA<FavoritePatientCardEntity>()
            .having((entity) => entity.userId, 'userId', 199)
            .having((entity) => entity.institutionId, 'institutionId', 92506)
            .having((entity) => entity.nickname, 'nickname', '太郎')
            .having((entity) => entity.localId, 'localId', '1100')
            .having((entity) => entity.lastReceptionDate, 'lastReceptionDate',
                '2021/06/25(金) 09:00')
            .having((entity) => entity.reserveDate, 'reserveDate',
                '2018/08/25(土) 16:00')
            .having((entity) => entity.isPatient, 'isPatient', true),
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_userDao.get());
    });
  });

  group('Error testing of the get patient card repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          userId: anyNamed('userId'),
          institutionId: anyNamed('institutionId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        _repository.get(userId: 100, institutionId: 200),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_userDao.get());
    });
  });
}
