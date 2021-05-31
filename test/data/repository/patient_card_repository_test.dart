import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import '../../fixture.dart';
import 'patient_card_repository_test.mocks.dart';

@GenerateMocks([PatientCardApi])
void main() {
  late MockPatientCardApi _api;
  late PatientCardRepository _repository;

  setUp(() async {
    _api = MockPatientCardApi();
    _repository = PatientCardRepositoryImpl(patientCardApi: _api);
  });

  group('Testing the patient card repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(
        _api.get(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('patient_card.json'));
      // Run the test method.
      final patientCardList = await _repository.fetchList();
      // Validate the result objects.
      expect(
        patientCardList,
        isA<List<PatientCardEntity>>()
            .having((list) => list, 'isNotnull', isNotNull)
            .having((list) => list.length, 'length', 3)
            .having((list) => list[0].nickname, 'nickname', '太郎')
            .having((list) => list[0].qrCodeImageUrl, 'qrCodeImageUrl',
                'qr/1344/ueR8q99hD7Ux4VrK.png')
            .having((list) => list[1].nickname, 'nickname', '花子')
            .having((list) => list[1].qrCodeImageUrl, 'qrCodeImageUrl',
                'qr/1372/MbQRuYNDyPFxLPhY.png')
            .having((list) => list[2].nickname, 'nickname', '次郎')
            .having((list) => list[2].qrCodeImageUrl, 'qrCodeImageUrl',
                'qr/1373/Sqfl9SawLEVwwzcE.png'),
      );
      // Validate the method call.
      verify(_api.get(authenticationToken: anyNamed('authenticationToken')));
    });
  });

  group('Error testing of the patient card repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
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
    });
  });
}
