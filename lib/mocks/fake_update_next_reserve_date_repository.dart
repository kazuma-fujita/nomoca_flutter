import 'package:nomoca_flutter/data/repository/update_next_reserve_date_repository.dart';

class FakeUpdateNextReserveDateRepositoryImpl
    extends UpdateNextReserveDateRepository {
  FakeUpdateNextReserveDateRepositoryImpl();

  @override
  Future<void> updateNextReserveDate(
          {required int userId,
          required int institutionId,
          required String reserveDate}) async =>
      Future.delayed(const Duration(seconds: 2), () => Future.value());
}
