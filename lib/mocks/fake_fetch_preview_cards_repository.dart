import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_preview_cards_repository.dart';

class FakeFetchPreviewCardsRepositoryImpl extends FetchPreviewCardsRepository {
  FakeFetchPreviewCardsRepositoryImpl();

  final _fakePreviewCardsEntity =
      const PreviewCardsEntity(sourceUserId: 123, patients: [
    PreviewCardPatientEntity(
      nameKana: 'ｻﾄｳ ﾀﾛｳ',
      localId: '12345',
      institution: PreviewCardInstitutionEntity(
        institutionId: 1234,
        institutionName: '田中歯科',
      ),
    ),
    PreviewCardPatientEntity(
      nameKana: 'ｻﾄｳ ﾀﾛｳ',
      localId: '6789012345',
      institution: PreviewCardInstitutionEntity(
        institutionId: 5678,
        institutionName: '長い名前デンタルクリニック長い名前デンタルクリニック',
      ),
    )
  ]);

  @override
  Future<PreviewCardsEntity> fetchCards({
    required String userToken,
    int? familyUserId,
  }) async =>
      Future.delayed(const Duration(seconds: 3), () => _fakePreviewCardsEntity);
// Future.error(Exception('QR read error'));
}
