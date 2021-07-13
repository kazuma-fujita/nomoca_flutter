import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/environment_variables.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/presentation/institution_view.dart';
import 'package:nomoca_flutter/presentation/notification_detail_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/sign_in_view.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view_model.dart';
import 'package:nomoca_flutter/presentation/top_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/notification_list_reducer.dart';
import 'package:nomoca_flutter/themes/easy_loading_theme.dart';

import 'constants/db_table_names.dart';
import 'data/entity/remote/patient_card_entity.dart';

final userDaoProvider = Provider(
  (_) => UserDaoImpl(Hive.box<User>(DBTableNames.users)),
);

final apiClientProvider = Provider(
  (_) => ApiClientImpl(
    baseUrl:
        '${EnvironmentVariables.nomocaApiBaseUrl}/${NomocaApiProperties.apiVersion}',
  ),
);

final authenticationApiProvider = Provider(
  (ref) => AuthenticationApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final authenticationRepositoryProvider = Provider(
  (ref) => AuthenticationRepositoryImpl(
    authenticationApi: ref.read(authenticationApiProvider),
  ),
);

final signupViewModelProvider = StateNotifierProvider.autoDispose(
  (ref) => SignUpViewModel(
    authenticationRepository: ref.read(authenticationRepositoryProvider),
  ),
);

Future<void> main() async {
  const contentsBaseUrl = 'https://contents-debug.nomoca.com';
  initEasyLoading();
  // Initializes Hive.
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  await Hive.openBox<User>(DBTableNames.users);
  runApp(
    ProviderScope(
      overrides: [
        patientCardState.overrideWithValue(
          // AsyncValue.error(Exception('network error')),
          const AsyncData([
            PatientCardEntity(
              nickname: '太郎',
              qrCodeImageUrl: '$contentsBaseUrl/qr/1344/ueR8q99hD7Ux4VrK.png',
            ),
            PatientCardEntity(
              nickname: '花子',
              qrCodeImageUrl: '$contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
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
        updateFavoriteProvider
            .overrideWithProvider((ref, param) => Future.value()),
        // updateFavoriteProvider.overrideWithProvider(
        //   (ref, param) => throw Exception('Error message.'),
        // ),
        fetchNotificationListRepositoryProvider
            .overrideWithValue(FakeFetchNotificationListRepositoryImpl()),
        updateReadPostProvider
            .overrideWithProvider((ref, param) => Future.value()),
        fetchFamilyUserListRepositoryProvider
            .overrideWithValue(FakeFetchFamilyUserListRepositoryImpl()),
        createFamilyUserProvider.overrideWithProvider((ref, param) =>
            Future.value(const UserNicknameEntity(id: 1234, nickname: '花子'))),
        updateFamilyUserProvider.overrideWithProvider((ref, param) =>
            Future.value(const UserNicknameEntity(id: 1234, nickname: '次郎'))),
        deleteFamilyUserProvider
            .overrideWithProvider((ref, param) => Future.value()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomoca application',
      theme: ThemeData(primaryColor: Colors.white),
      routes: <String, WidgetBuilder>{
        RouteNames.signUp: (_) => SignUpView(),
        RouteNames.signIn: (_) => SignInView(),
        RouteNames.institution: (_) => InstitutionView(),
        RouteNames.upsertUser: (_) => UpsertUserView(),
        RouteNames.notificationDetail: (_) => NotificationDetailView(),
      },
      home: TopView(),
      builder: EasyLoading.init(),
    );
  }
}
