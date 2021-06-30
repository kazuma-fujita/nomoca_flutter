import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/get_institution_api.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/main.dart';

final _getInstitutionApiProvider = Provider.autoDispose(
  (ref) => GetInstitutionApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final getInstitutionRepositoryProvider =
    Provider.autoDispose<GetInstitutionRepository>(
  (ref) => GetInstitutionRepositoryImpl(
    getInstitutionApi: ref.read(_getInstitutionApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final getInstitutionProvider =
    FutureProvider.autoDispose.family<InstitutionEntity, int>(
  (ref, institutionId) async {
    final repository = ref.read(getInstitutionRepositoryProvider);
    return repository.getInstitution(institutionId: institutionId);
  },
);
