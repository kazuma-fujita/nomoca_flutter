import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/repository/authentication_repository.dart';
import 'package:nomoca_flutter/presentation/sign_up/sign_up_view_model.dart';
import 'sign_up_view_model_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late MockAuthenticationRepository _repository;
  late SignUpViewModel _viewModel;

  setUp(() async {
    _repository = MockAuthenticationRepository();
    _viewModel = SignUpViewModel(authenticationRepository: _repository);
  });

  group('Testing the sign up view model.', () {
    test('Testing the basic sign up view model.', () async {
      expect(_viewModel.debugState.data, isNotNull);
      expect(_viewModel.debugState.data!.value, false);
      when(
        _repository.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
      ).thenAnswer((_) => Future.value());
      await _viewModel.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
      );
      verify(
        _repository.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
      );
      expect(_viewModel.debugState.data, isNotNull);
      expect(_viewModel.debugState.data!.value, true);
      reset(_repository);
    });
  });

  group('Testing the pattern of sign up view model errors.', () {
    test('Testing the pattern of sign up view model exception error.',
        () async {
      when(
        _repository.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
      ).thenThrow(Exception('Error message'));

      await _viewModel.signUp(
        mobilePhoneNumber: '09012345678',
        nickname: 'test-user',
      );

      verify(
        _repository.signUp(
          mobilePhoneNumber: '09012345678',
          nickname: 'test-user',
        ),
      );

      expect(
        _viewModel.debugState.toString(),
        AsyncError<bool>(Exception('Error message')).toString(),
      );
    });
  });
}
