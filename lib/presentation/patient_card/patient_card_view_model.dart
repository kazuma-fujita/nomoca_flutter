import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class PatientCardViewModel
    extends StateNotifier<AsyncValue<List<PatientCardEntity>>> {
  PatientCardViewModel({required this.patientCardRepository})
      : super(const AsyncData([]));

  final PatientCardRepository patientCardRepository;

  Future<void> fetchList() async {
    state = const AsyncLoading();
    try {
      final patientCardList = await patientCardRepository.fetchList();
      state = AsyncData(patientCardList);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
