import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';

class FakeGetFavoritePatientCardRepositoryImpl
    extends GetFavoritePatientCardRepository {
  FakeGetFavoritePatientCardRepositoryImpl();

  final entity = const FavoritePatientCardEntity(
    institutionId: 90093,
    userId: 199,
    nickname: '太郎',
    localId: '1100',
    reserveDate: '2021/07/06(火) 16:00',
    // reserveDate: null,
    lastReceptionDate: '2021/06/25(金) 09:00',
    isPatient: false,
  );

  @override
  Future<FavoritePatientCardEntity> get({
    required int userId,
    required int institutionId,
  }) async =>
      Future.delayed(const Duration(seconds: 1), () => entity);
}
