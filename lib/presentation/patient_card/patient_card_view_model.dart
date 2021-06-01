import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:state_notifier/state_notifier.dart';

// ignore: one_member_abstracts
abstract class PatientCardViewModel {
  Future<void> fetchList();
}

class PatientCardViewModelImpl
    extends StateNotifier<AsyncValue<List<PatientCardEntity>>>
    implements PatientCardViewModel {
  PatientCardViewModelImpl({required this.patientCardRepository})
      : super(const AsyncData([]));

  final PatientCardRepository patientCardRepository;

  @override
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
