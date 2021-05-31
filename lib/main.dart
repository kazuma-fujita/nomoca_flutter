import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view.dart';
import 'package:nomoca_flutter/constants/environment_variables.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view_model.dart';

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

final patientCardApiProvider = Provider(
  (ref) => PatientCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final patientCardRepositoryProvider = Provider(
  (ref) => PatientCardRepositoryImpl(
    patientCardApi: ref.read(patientCardApiProvider),
  ),
);

final patientCardViewModelProvider = StateNotifierProvider.autoDispose(
  (ref) => PatientCardViewModel(
    patientCardRepository: ref.read(patientCardRepositoryProvider),
  ),
);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomoca application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpView(),
    );
  }
}
