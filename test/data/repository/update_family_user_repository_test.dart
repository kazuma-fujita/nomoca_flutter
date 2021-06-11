import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';

import '../../fixture.dart';
import 'update_family_user_repository_test.mocks.dart';

@GenerateMocks([UpdateFamilyUserApi])
void main() {
  late MockUpdateFamilyUserApi _api;
  late UpdateFamilyUserRepository _repository;

  setUp(() async {
    _api = MockUpdateFamilyUserApi();
    _repository = UpdateFamilyUserRepositoryImpl(updateFamilyUserApi: _api);
  });

  group('Testing the update family user repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenAnswer((_) async => fixture('update_family_user.json'));
      // Run the test method.
      final entity =
          await _repository.updateUser(nickname: '花子', familyUserId: 1372);
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
        familyUserId: anyNamed('familyUserId'),
      ));
    });
  });

  group('Error testing of the update family user repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
          familyUserId: anyNamed('familyUserId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.updateUser(nickname: '花子', familyUserId: 1372),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
        familyUserId: anyNamed('familyUserId'),
      ));
    });
  });
}
