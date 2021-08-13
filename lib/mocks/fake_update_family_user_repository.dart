import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';

class FakeUpdateFamilyUserRepositoryImpl extends UpdateFamilyUserRepository {
  FakeUpdateFamilyUserRepositoryImpl();

  @override
  Future<UserNicknameEntity> updateUser({
    required int familyUserId,
    required String nickname,
  }) async =>
      Future.delayed(
        const Duration(seconds: 3),
        () => Future.value(
          const UserNicknameEntity(id: 1234, nickname: '次郎'),
        ),
      );
}
