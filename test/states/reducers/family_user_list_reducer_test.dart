@Skip('currently failing')
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

import '../../presentation/family_user_integration_test.mocks.dart';

@GenerateMocks([FetchFamilyUserListRepository])
void main() {
  final _listRepository = MockFetchFamilyUserListRepository();

  setUp(() {
    reset(_listRepository);
  });

  ProviderContainer setUpProviderContainer(FamilyUserAction action) {
    return ProviderContainer(
      overrides: [
        // familyUserListState.overrideWithProvider(
        //   StateProvider.autoDispose((ref) {
        //     return Future.value([
        //       const UserNicknameEntity(id: 1234, nickname: '花子'),
        //     ]);
        //   }),
        // ),
        fetchFamilyUserListRepositoryProvider
            .overrideWithValue(_listRepository),
        familyUserActionDispatcher
            .overrideWithProvider(StateProvider.autoDispose((ref) => action)),
      ],
    );
  }

  group('Testing family user list provider.', () {
    test('Testing fetch family user list.', () async {
      when(_listRepository.fetchList()).thenAnswer(
          (_) async => [const UserNicknameEntity(id: 1234, nickname: '花子')]);
      final container =
          setUpProviderContainer(const FamilyUserAction.fetchList());
      // The first read if the loading state
      expect(container.read(familyUserListReducer), const AsyncValue.loading());
      // Wait for the request to finish
      await container.refresh(familyUserListReducer);
      // await Future<void>.value();
      // Exposes the data fetched
      expect(container.read(familyUserListReducer).data!.value, [
        isA<UserNicknameEntity>()
            .having((entity) => entity.id, 'id', 1234)
            .having((entity) => entity.nickname, 'nickname', '花子'),
      ]);
      verify(_listRepository.fetchList());
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
