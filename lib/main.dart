import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/environment_variables.dart';
import 'package:nomoca_flutter/constants/nomoca_api_properties.dart';
import 'package:nomoca_flutter/data/api/api_client.dart';
import 'package:nomoca_flutter/data/api/authentication_api.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/presentation/signup/signup_view.dart';
import 'package:nomoca_flutter/presentation/signup/signup_view_model.dart';

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
  (ref) => SignupViewModel(
    authenticationRepository: ref.read(authenticationRepositoryProvider),
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
      home: SignupView(),
    );
  }
}
