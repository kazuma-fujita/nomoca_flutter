import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';

import 'patient_card_view_test.mocks.dart';

@GenerateMocks([PatientCardViewModel])
void main() {
  late MockPatientCardViewModel _viewModel;
  late ProviderScope _providerScope;

  setUp(() {
    _viewModel = MockPatientCardViewModel();
    _providerScope = ProviderScope(
      overrides: [
        patientCardViewModelProvider.overrideWithValue(_viewModel),
      ],
      child: PatientCardView(),
    );
  });

  group('Testing the patient card view.', () {
    testWidgets('Testing XXXXX', (WidgetTester tester) async {
      expect('A', 'A');

      // when(_viewModel.fetchList())

      await tester.pumpWidget(_providerScope);
    });
  });
}
