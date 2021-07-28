import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/fetch_patient_cards_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_patient_cards_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final patientCardApiProvider = Provider.autoDispose(
  (ref) => PatientCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final patientCardRepositoryProvider =
    Provider.autoDispose<FetchPatientCardsRepository>(
  (ref) => PatientCardRepositoryImpl(
    patientCardApi: ref.read(patientCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final patientCardProvider =
    FutureProvider.autoDispose<List<PatientCardEntity>>((ref) async {
  return ref.read(patientCardRepositoryProvider).fetchList();
});
