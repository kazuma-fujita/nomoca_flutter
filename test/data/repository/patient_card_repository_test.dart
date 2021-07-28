import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/fetch_patient_cards_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_patient_cards_repository.dart';
import '../../fixture.dart';
import 'patient_card_repository_test.mocks.dart';

@GenerateMocks([FetchPatientCardsApi, UserDao])
void main() {
  late MockFetchPatientCardsApi _api;
  late FetchPatientCardsRepository _repository;
  late MockUserDao _userDao;

  setUp(() async {
    _api = MockFetchPatientCardsApi();
    _userDao = MockUserDao();
    _repository =
        PatientCardRepositoryImpl(patientCardApi: _api, userDao: _userDao);
  });

  group('Testing the patient card repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api.get(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('patient_card.json'));
      // Run the test method.
      final patientCardList = await _repository.fetchList();
      // Validate the result objects.
      // const contentsBaseUrl = 'https://contents-debug.nomoca.com';
      expect(
        patientCardList,
        isA<List<PatientCardEntity>>()
            .having((list) => list, 'isNotnull', isNotNull)
            .having((list) => list.length, 'length', 3)
            .having((list) => list[0].nickname, 'nickname', '太郎')
            .having((list) => list[0].qrCodeImageUrl, 'qrCodeImageUrl',
                '/qr/1344/ueR8q99hD7Ux4VrK.png')
            .having((list) => list[1].nickname, 'nickname', '花子')
            .having((list) => list[1].qrCodeImageUrl, 'qrCodeImageUrl',
                '/qr/1372/MbQRuYNDyPFxLPhY.png')
            .having((list) => list[2].nickname, 'nickname', '次郎')
            .having((list) => list[2].qrCodeImageUrl, 'qrCodeImageUrl',
                '/qr/1373/Sqfl9SawLEVwwzcE.png'),
      );
      // Validate the method call.
      verify(_api.get(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });

  group('Error testing of the patient card repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(_userDao.get()).thenReturn(User()..authenticationToken = 'dummy');
      when(
        _api.get(
          authenticationToken: anyNamed('authenticationToken'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.fetchList(),
        throwsException,
      );
      // Validate the method call.
      verify(_api.get(authenticationToken: anyNamed('authenticationToken')));
      verify(_userDao.get());
    });
  });
}
