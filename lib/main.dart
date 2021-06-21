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
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/notification_detail_view.dart';
import 'package:nomoca_flutter/presentation/notification_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view_model.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
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
        notificationListState.overrideWithProvider(
          StateProvider.autoDispose((ref) {
            return Future.value([
              const NotificationEntity(
                id: 140188,
                isRead: false,
                detail: NotificationDetailEntity(
                    title: 'お知らせTitle1',
                    body: 'お知らせBody1',
                    contributor: 'テストクリニックからのお知らせ',
                    deliveryDate: '2021/06/21 12:15',
                    // imageUrl: null),
                    imageUrl:
                        '$contentsBaseUrl/institutions/140188/image1/381e52949a3fb4ce444a6de59c8e1190.jpg'),
              ),
              const NotificationEntity(
                id: 141338,
                isRead: false,
                detail: NotificationDetailEntity(
                    title: 'お知らせTitle2お知らせTitle2お知らせタイトル2お知らせタイトル2',
                    // ignore: lines_longer_than_80_chars
                    body:
                        'お知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\nお知らせBody2\n',
                    contributor: 'テスト歯科からのお知らせテスト歯科からのお知らせテスト歯科からのお知らせ',
                    deliveryDate: '2021/05/01 09:05',
                    // imageUrl: null),
                    imageUrl:
                        '$contentsBaseUrl/institutions/141338/image1/a35d6ac6ad8258db2891a1bc69ae8c1b.jpg'),
              ),
            ]);
          }),
        ),
        familyUserListState.overrideWithProvider(
          StateProvider.autoDispose((ref) {
            return Future.value([
              const UserNicknameEntity(id: 1234, nickname: '花子'),
              const UserNicknameEntity(id: 1235, nickname: '次郎'),
            ]);
          }),
        ),
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
        RouteNames.upsertUser: (_) => UpsertUserView(),
        RouteNames.notificationDetail: (_) => NotificationDetailView(),
      },
      home: NotificationListView(),
      builder: EasyLoading.init(),
    );
  }
}
