import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

void main() {
  ProviderContainer setUpProviderContainer(FamilyUserAction action) {
    return ProviderContainer(
      overrides: [
        familyUserListState.overrideWithProvider(
          StateProvider((ref) {
            return Future.value([
              const UserNicknameEntity(id: 1234, nickname: '花子'),
            ]);
          }),
        ),
        familyUserActionDispatcher
            .overrideWithProvider(StateProvider((ref) => action)),
      ],
    );
  }

  group('Testing family user list provider.', () {
    test('Testing fetch family user list.', () async {
      final container =
          setUpProviderContainer(const FamilyUserAction.fetchList());
      // The first read if the loading state
      expect(container.read(familyUserListReducer), const AsyncValue.loading());
      // Wait for the request to finish
      await container.refresh(familyUserListReducer);
      // Exposes the data fetched
      expect(container.read(familyUserListReducer).data!.value, [
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1234)
            .having((entity) => entity.nickname, 'nickname', '花子'),
      ]);
    });

    test('Testing create family user.', () async {
      final container = setUpProviderContainer(
        const FamilyUserAction.create(
          UserNicknameEntity(id: 1235, nickname: '次郎'),
        ),
      );
      // The first read if the loading state
      expect(container.read(familyUserListReducer), const AsyncValue.loading());
      // Wait for the request to finish
      await container.refresh(familyUserListReducer);
      // Exposes the data fetched
      expect(container.read(familyUserListReducer).data!.value, [
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1234)
            .having((entity) => entity.nickname, 'nickname', '花子'),
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1235)
            .having((entity) => entity.nickname, 'nickname', '次郎'),
      ]);
    });

    test('Testing update family user.', () async {
      final container = setUpProviderContainer(
        const FamilyUserAction.update(
          UserNicknameEntity(id: 1234, nickname: '次郎'),
        ),
      );
      // The first read if the loading state
      expect(container.read(familyUserListReducer), const AsyncValue.loading());
      // Wait for the request to finish
      await container.refresh(familyUserListReducer);
      // Exposes the data fetched
      expect(container.read(familyUserListReducer).data!.value, [
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1234)
            .having((entity) => entity.nickname, 'nickname', '次郎'),
      ]);
    });

    test('Testing delete family user.', () async {
      final container = setUpProviderContainer(
        const FamilyUserAction.delete(
          UserNicknameEntity(id: 1234, nickname: '花子'),
        ),
      );
      // The first read if the loading state
      expect(container.read(familyUserListReducer), const AsyncValue.loading());
      // Wait for the request to finish
      await container.refresh(familyUserListReducer);
      // Exposes the data fetched
      expect(container.read(familyUserListReducer).data!.value, []);
    });
  });
}
