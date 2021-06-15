import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/api/update_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';

import '../../fixture.dart';
import 'update_user_repository_test.mocks.dart';

@GenerateMocks([UpdateUserApi])
void main() {
  late MockUpdateUserApi _api;
  late UpdateUserRepository _repository;

  setUp(() async {
    _api = MockUpdateUserApi();
    _repository = UpdateUserRepositoryImpl(updateUserApi: _api);
  });

  group('Testing the update user repository.', () {
    test('Testing the conversion of api responses to entities.', () async {
      // Create the stub.
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
          userId: anyNamed('userId'),
        ),
      ).thenAnswer((_) async => fixture('update_user.json'));
      // Run the test method.
      final entity = await _repository.updateUser(nickname: '花子', userId: 1372);
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
        userId: anyNamed('userId'),
      ));
    });
  });

  group('Error testing of the update user repository.', () {
    test('Error testing for json conversion.', () async {
      // Create the stub.
      when(
        _api(
          authenticationToken: anyNamed('authenticationToken'),
          nickname: anyNamed('nickname'),
          userId: anyNamed('userId'),
        ),
      ).thenAnswer((_) async => fixture('incorrect_format.json'));
      // Run the test method.
      expect(
        () => _repository.updateUser(nickname: '花子', userId: 1372),
        throwsException,
      );
      // Validate the method call.
      verify(_api(
        authenticationToken: anyNamed('authenticationToken'),
        nickname: anyNamed('nickname'),
        userId: anyNamed('userId'),
      ));
    });
  });
}
