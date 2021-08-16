import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/version_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';
import 'package:nomoca_flutter/data/repository/get_version_repository.dart';

class FakeGetVersionRepositoryImpl extends GetVersionRepository {
  FakeGetVersionRepositoryImpl();

  @override
  Future<String> getVersion() async => Future.delayed(
        const Duration(seconds: 2),
        () => Future.value('1.1.0.1(1.1.7.1)'),
      );
}
