import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';
import 'package:state_notifier/state_notifier.dart';

class MockPatientCardViewModelImpl
    extends StateNotifier<AsyncValue<List<PatientCardEntity>>>
    implements PatientCardViewModel {
  MockPatientCardViewModelImpl() : super(const AsyncData([]));

  @override
  Future<void> fetchList() async {
    state = const AsyncLoading();
    try {
      print('view model fetchList.');
      // await Future.delayed(const Duration(seconds: 1));
      const contentsBaseUrl = 'https://contents-debug.nomoca.com';
      final patientCardList = [
        const PatientCardEntity(
          nickname: '太郎',
          qrCodeImageUrl: '$contentsBaseUrl/qr/1344/ueR8q99hD7Ux4VrK.png',
        )
      ];
      state = AsyncData(patientCardList);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
