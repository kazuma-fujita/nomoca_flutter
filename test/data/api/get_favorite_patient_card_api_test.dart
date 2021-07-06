import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/get_favorite_patient_card_api.dart';

import 'get_favorite_patient_card_api_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient _apiClient;
  late GetFavoritePatientCardApi _api;

  setUp(() async {
    _apiClient = MockApiClient();
    _api = GetFavoritePatientCardApiImpl(apiClient: _apiClient);
  });

  group('Testing the get favorite patient card API.', () {
    test('Testing the get method.', () async {
      // Create the stub.
      when(
        _apiClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => '{"dummy_response": "dummy text"}');
      // Run the test method.
      final response = await _api(
          authenticationToken: 'dummy_token', userId: 100, institutionId: 200);
      expect(response, '{"dummy_response": "dummy text"}');
      // Validate the method call.
      verify(_apiClient.get(
        any,
        headers: anyNamed('headers'),
      ));
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
        () => _api(
            authenticationToken: 'dummy_token',
            userId: 100,
            institutionId: 200),
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
