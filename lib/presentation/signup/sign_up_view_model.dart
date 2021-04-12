import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class SignUpViewModel extends StateNotifier<AsyncValue<bool>> {
  SignUpViewModel({required this.authenticationRepository})
      : super(const AsyncData(false));

  final AuthenticationRepository authenticationRepository;

  Future<void> signUp() async {
    state = const AsyncLoading();
    try {
      await authenticationRepository.signUp(
          mobilePhoneNumber: '05011112224', nickname: 'flutter-test1');
      state = const AsyncData(true);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
