import 'package:nomoca_flutter/data/repository/update_local_id_repository.dart';

class FakeUpdateLocalIdRepositoryImpl extends UpdateLocalIdRepository {
  FakeUpdateLocalIdRepositoryImpl();

  @override
  Future<void> updateLocalId(
          {required int userId,
          required int institutionId,
          required String localId}) async =>
      Future.delayed(const Duration(seconds: 2), () => Future.value());
  // Future.delayed(const Duration(seconds: 2),
  //     () => Future.error(Exception('Error Message.')));
}
