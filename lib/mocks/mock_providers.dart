import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_preview_cards_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/user_management_repository.dart';
import 'package:nomoca_flutter/mocks/fake_create_family_user_repository.dart';
import 'package:nomoca_flutter/mocks/fake_create_user_repository.dart';
import 'package:nomoca_flutter/mocks/fake_fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/mocks/fake_update_family_user_repository.dart';
import 'package:nomoca_flutter/mocks/fake_update_local_id_repository.dart';
import 'package:nomoca_flutter/mocks/fake_update_next_reserve_date_repository.dart';
import 'package:nomoca_flutter/mocks/fake_update_user_repository.dart';
import 'package:nomoca_flutter/mocks/fake_user_dao.dart';
import 'package:nomoca_flutter/mocks/fake_get_version_repository.dart';
import 'package:nomoca_flutter/states/providers/authentication_provider.dart';
import 'package:nomoca_flutter/states/providers/create_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/create_user_provider.dart';
import 'package:nomoca_flutter/states/providers/delete_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/fetch_preview_cards_provider.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/get_version_provider.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/providers/registration_card_provider.dart';
import 'package:nomoca_flutter/states/providers/send_short_message_provider.dart';
import 'package:nomoca_flutter/states/providers/update_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/providers/update_local_id_provider.dart';
import 'package:nomoca_flutter/states/providers/update_next_reserve_date_provider.dart';
import 'package:nomoca_flutter/states/providers/update_read_post_provider.dart';
import 'package:nomoca_flutter/states/providers/update_user_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/notification_list_reducer.dart';

import 'fake_fetch_preview_cards_repository.dart';
import 'fake_get_favorite_patient_card_repository.dart';

class MockProviders {
  static const _contentsBaseUrl = 'https://contents-debug.nomoca.com';

  static List<Override> overrides() {
    return [
      userDaoProvider.overrideWithValue(FakeUserDaoImpl()),
      sendShortMessageRepositoryProvider
          .overrideWithValue(FakeSendShortMessageRepositoryImpl()),
      createUserRepositoryProvider
          .overrideWithValue(FakeCreateUserRepositoryImpl()),
      authenticationRepositoryProvider
          .overrideWithValue(FakeAuthenticationRepositoryImpl()),
      patientCardProvider.overrideWithValue(
        const AsyncData([
          PatientCardEntity(
            nickname: '太郎',
            qrCodeImageUrl: '$_contentsBaseUrl/qr/1344/ueR8q99hD7Ux4VrK.png',
          ),
          PatientCardEntity(
            nickname: '花子',
            qrCodeImageUrl: '$_contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
          ),
        ]),
      ),
      // familyUserListReducer.overrideWithValue(const AsyncValue.data([])),
      // familyUserListReducer.overrideWithValue(const AsyncValue.data([
      //   UserNicknameEntity(id: 1234, nickname: '花子'),
      //   UserNicknameEntity(id: 1235, nickname: '次郎'),
      // ])),
      // Error (overrideWithProvider pattern)
      // createFamilyUserProvider.overrideWithProvider(
      //   (ref, param) => throw Exception('Error message.'),
      // ),
      // Loading (overrideWithProvider pattern)
      // createFamilyUserProvider.overrideWithProvider(
      //   (ref, param) => Future.delayed(const Duration(seconds: 5)),
      // ),
      // createFamilyUserProvider.overrideWithProvider(
      //   (ref, param) => Future<void>.value(),
      // ),
      getInstitutionRepositoryProvider
          .overrideWithValue(FakeGetInstitutionRepositoryImpl()),
      fetchFavoriteListRepositoryProvider
          .overrideWithValue(FakeFetchFavoriteListRepositoryImpl()),
      getFavoritePatientCardRepositoryProvider
          .overrideWithValue(FakeGetFavoritePatientCardRepositoryImpl()),
      updateLocalIdRepositoryProvider
          .overrideWithValue(FakeUpdateLocalIdRepositoryImpl()),
      updateNextReserveDateRepositoryProvider
          .overrideWithValue(FakeUpdateNextReserveDateRepositoryImpl()),
      keywordSearchRepositoryProvider
          .overrideWithValue(FakeKeywordSearchRepositoryImpl()),
      updateFavoriteProvider.overrideWithProvider(
        (param) => AutoDisposeProvider<AsyncValue<void>>(
          (ref) => const AsyncValue.data(null),
        ),
      ),
      // updateFavoriteProvider.overrideWithProvider(
      //   (ref, param) => throw Exception('Error message.'),
      // ),
      fetchNotificationListRepositoryProvider
          .overrideWithValue(FakeFetchNotificationListRepositoryImpl()),
      // updateReadPostProvider
      //     .overrideWithProvider((ref, param) => Future.value()),
      updateReadPostProvider.overrideWithProvider(
        (param) => AutoDisposeProvider<AsyncValue<void>>(
          (ref) => const AsyncValue.data(null),
        ),
      ),
      fetchFamilyUserListRepositoryProvider
          .overrideWithValue(FakeFetchFamilyUserListRepositoryImpl()),
      updateUserRepositoryProvider
          .overrideWithValue(FakeUpdateUserRepositoryImpl()),
      createFamilyUserRepositoryProvider
          .overrideWithValue(FakeCreateFamilyUserRepositoryImpl()),
      updateFamilyUserRepositoryProvider
          .overrideWithValue(FakeUpdateFamilyUserRepositoryImpl()),
      deleteFamilyUserProvider.overrideWithProvider(
        (param) => AutoDisposeProvider<AsyncValue<void>>(
          (ref) => const AsyncValue.data(null),
        ),
      ),
      // deleteFamilyUserProvider
      //     .overrideWithProvider((ref, param) => Future.value()),
      userManagementRepositoryProvider
          .overrideWithValue(FakeUserManagementRepositoryImpl()),
      fetchPreviewCardsRepositoryProvider
          .overrideWithValue(FakeFetchPreviewCardsRepositoryImpl()),
      registrationCardRepositoryProvider
          .overrideWithValue(FakeRegistrationCardRepositoryImpl()),
      getVersionRepositoryProvider
          .overrideWithValue(FakeGetVersionRepositoryImpl()),
    ];
  }
}
