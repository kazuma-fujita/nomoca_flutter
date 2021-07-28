import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/fetch_patient_cards_api.dart';
import 'patient_card_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient _apiClient;
  late FetchPatientCardsApi _patientCardApi;

  setUp(() async {
    _apiClient = MockApiClient();
    _patientCardApi = PatientCardApiImpl(apiClient: _apiClient);
  });

  group('Testing the patient card API.', () {
    test('Testing the get method.', () async {
      // Create the stub.
      when(
        _apiClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => '{"dummy_response": "dummy text"}');
      // Run the test method.
      final response =
          await _patientCardApi.get(authenticationToken: 'dummy_token');
      expect(response, '{"dummy_response": "dummy text"}');
      // Validate the method call.
      verify(
        _apiClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      );
    });
  });

  group('Testing the pattern of API errors.', () {
    test('Testing the pattern of get method error.', () async {
      // Create the stub.
      when(
        _apiClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenThrow(
        Exception('error message'),
      );
      // Run the test method.
      expect(
        () => _patientCardApi.get(authenticationToken: 'dummy_token'),
        throwsException,
      );
      // Validate the method call.
      verify(
        _apiClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      );
    });
  });
}
