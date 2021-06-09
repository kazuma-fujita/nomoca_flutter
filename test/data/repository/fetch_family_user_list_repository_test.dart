import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/family_user_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import '../../fixture.dart';
import 'fetch_family_user_list_repository_test.mocks.dart';

@GenerateMocks([FetchFamilyUserListApi])
void main() {
  late MockFetchFamilyUserListApi _api;
  late FetchFamilyUserListRepository _repository;

  setUp(() async {
    _api = MockFetchFamilyUserListApi();
    _repository =
        FetchFamilyUserListRepositoryImpl(fetchFamilyUserListApi: _api);
  });

  group('Testing the fetch family user list repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(
        _api(authenticationToken: anyNamed('authenticationToken')),
      ).thenAnswer((_) async => fixture('family_user_list.json'));
      // Run the test method.
      final patientCardList = await _repository.fetchList();
      // Validate the result objects.
      expect(
        patientCardList,
        [
          isA<FamilyUserEntity>()
              .having((entity) => entity.id, 'id', 1372)
              .having((entity) => entity.nickname, 'nickname', '花子'),
          isA<FamilyUserEntity>()
              .having((entity) => entity.id, 'id', 1373)
              .having((entity) => entity.nickname, 'nickname', '次郎')
        ],
      );
      // Validate the method call.
      verify(_api(authenticationToken: anyNamed('authenticationToken')));
    });
  });

  group('Error testing of the fetch family user list repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
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
    });
  });
}
