import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/constants/environment_variables.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view_model.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/themes/easy_loading_theme.dart';

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

void main() {
  const contentsBaseUrl = 'https://contents-debug.nomoca.com';
  initEasyLoading();
  runApp(
    ProviderScope(
      overrides: [
        patientCardProvider.overrideWithValue(
          AsyncValue.error(Exception('network error')),
          // const AsyncData([
          //   PatientCardEntity(
          //     nickname: '太郎',
          //     qrCodeImageUrl: '$contentsBaseUrl/qr/1344/ueR8q99hD7Ux4VrK.png',
          //   ),
          //   PatientCardEntity(
          //     nickname: '花子',
          //     qrCodeImageUrl: '$contentsBaseUrl/qr/1372/MbQRuYNDyPFxLPhY.png',
          //   ),
          // ]),
        ),
        familyUserListProvider.overrideWithValue(const AsyncValue.data([])),
        // familyUserListProvider.overrideWithValue(const AsyncValue.data([
        //   UserNicknameEntity(id: 1234, nickname: '花子'),
        //   UserNicknameEntity(id: 1235, nickname: '次郎'),
        // ])),
        // Error (overrideWithProvider pattern)
        // createFamilyUserProvider.overrideWithProvider(
        //   (ref, param) => throw Exception('Error message.'),
        // ),
        // Loading (overrideWithProvider pattern)
        createFamilyUserProvider.overrideWithProvider(
          (ref, param) => Future.delayed(const Duration(seconds: 5)),
        ),
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
      home: UpsertUserView(),
      builder: EasyLoading.init(),
    );
  }
}
