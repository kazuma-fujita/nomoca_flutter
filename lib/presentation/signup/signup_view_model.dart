import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class SignupViewModel extends StateNotifier<AsyncValue<void>> {
  SignupViewModel({required this.authenticationRepository})
      : super(const AsyncData(null));

  final AuthenticationRepository authenticationRepository;

  Future<void> signup() async {
    state = const AsyncLoading();
    try {
      await authenticationRepository.signUp(
          mobilePhoneNumber: '05011112224', nickname: 'flutter-test1');
      state = const AsyncData(null);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
