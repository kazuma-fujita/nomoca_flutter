import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';
import 'package:nomoca_flutter/presentation/bottom_navigation_bar_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/states/providers/authentication_provider.dart';
import 'package:nomoca_flutter/states/providers/create_user_provider.dart';
import 'package:nomoca_flutter/states/providers/delete_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/fetch_preview_cards_provider.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/providers/registration_card_provider.dart';
import 'package:nomoca_flutter/states/providers/send_short_message_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/providers/update_read_post_provider.dart';
import 'package:nomoca_flutter/states/providers/upsert_user_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/notification_list_reducer.dart';
import 'package:nomoca_flutter/themes/easy_loading_theme.dart';
import 'package:nomoca_flutter/themes/theme_data.dart';

import 'constants/db_table_names.dart';
import 'data/entity/remote/patient_card_entity.dart';
import 'data/repository/fetch_preview_cards_repository.dart';
import 'data/repository/user_management_repository.dart';

Future<void> main() async {
  initEasyLoading();
  // Initializes Hive.
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  await Hive.openBox<User>(DBTableNames.users);
  runApp(
    ProviderScope(
      overrides: _overrides,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomoca application',
      // Default theme
      theme: lightThemeData,
      // Dark mode theme
      darkTheme: lightThemeData,
      // darkTheme: darkThemeData,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BottomNavigationBarView(),
      // home: Navigator(
      //   // Debug用 QrReadConfirm画面引数設定
      //   onGenerateRoute: (_) => MaterialPageRoute(
      //     builder: (_) => QrReadConfirmView(),
      //     settings: const RouteSettings(arguments: fakePreviewCardsEntity),
      //   ),
      // ),
      builder: EasyLoading.init(),
    );
  }
}

const _contentsBaseUrl = 'https://contents-debug.nomoca.com';
final _overrides = [
  sendShortMessageRepositoryProvider
      .overrideWithValue(FakeSendShortMessageRepositoryImpl()),
  createUserProvider.overrideWithProvider(
    (param) => AutoDisposeProvider<AsyncValue<void>>(
      (ref) => const AsyncValue.data(null),
    ),
  ),
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
  createFamilyUserProvider.overrideWithProvider(
    (param) => AutoDisposeProvider<AsyncValue<UserNicknameEntity>>(
      (ref) => const AsyncValue.data(
        UserNicknameEntity(id: 1234, nickname: '花子'),
      ),
    ),
  ),
  // createFamilyUserProvider.overrideWithProvider((ref, param) =>
  //     Future.value(const UserNicknameEntity(id: 1234, nickname: '花子'))),
  updateFamilyUserProvider.overrideWithProvider(
    (param) => AutoDisposeProvider<AsyncValue<UserNicknameEntity>>(
      (ref) => const AsyncValue.data(
        UserNicknameEntity(id: 1234, nickname: '次郎'),
      ),
    ),
  ),
  // updateFamilyUserProvider.overrideWithProvider((ref, param) =>
  //     Future.value(const UserNicknameEntity(id: 1234, nickname: '次郎'))),
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
];
