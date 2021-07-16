import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';

final patientCardApiProvider = Provider.autoDispose(
  (ref) => PatientCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final patientCardRepositoryProvider =
    Provider.autoDispose<PatientCardRepository>(
  (ref) => PatientCardRepositoryImpl(
    patientCardApi: ref.read(patientCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final patientCardProvider =
    FutureProvider.autoDispose<List<PatientCardEntity>>((ref) async {
  return ref.read(patientCardRepositoryProvider).fetchList();
});
