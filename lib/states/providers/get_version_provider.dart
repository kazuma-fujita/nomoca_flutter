import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/get_institution_api.dart';
import 'package:nomoca_flutter/data/api/version_api.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/version_entity.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/data/repository/get_version_repository.dart';
import 'package:nomoca_flutter/states/providers/api_client_provider.dart';
import 'package:nomoca_flutter/states/providers/user_dao_provider.dart';
import 'package:package_info/package_info.dart';

final _getVersionApiProvider = Provider.autoDispose(
  (ref) => GetVersionApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final getVersionRepositoryProvider = Provider.autoDispose<GetVersionRepository>(
  (ref) => GetVersionRepositoryImpl(
    getVersionApi: ref.read(_getVersionApiProvider),
  ),
);

final getVersionProvider = FutureProvider.autoDispose<String>(
  (ref) async {
    return ref.read(getVersionRepositoryProvider).getVersion();
  },
);
