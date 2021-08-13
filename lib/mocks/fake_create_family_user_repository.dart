import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';

class FakeCreateFamilyUserRepositoryImpl extends CreateFamilyUserRepository {
  FakeCreateFamilyUserRepositoryImpl();

  @override
  Future<UserNicknameEntity> createUser({
    required String nickname,
  }) async =>
      Future.delayed(
        const Duration(seconds: 3),
        () => Future.value(
          const UserNicknameEntity(id: 1235, nickname: '次郎'),
        ),
      );
}
