import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/repository/get_version_repository.dart';
import 'package:nomoca_flutter/presentation/components/settings_view.dart';
import 'package:nomoca_flutter/states/providers/get_version_provider.dart';

import 'settings_view_test.mocks.dart';

@GenerateMocks([GetVersionRepository])
void main() {
  final _repository = MockGetVersionRepository();

  tearDown(() {
    reset(_repository);
  });

  ProviderScope setUpProviderScope() {
    return ProviderScope(
      overrides: [
        getVersionRepositoryProvider.overrideWithValue(_repository),
      ],
      child: MaterialApp(
        home: SettingsView(),
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('設定'), findsOneWidget);
    expect(find.text('通知設定'), findsOneWidget);
    expect(find.text('利用規約'), findsOneWidget);
    expect(find.text('プライバシーポリシー'), findsOneWidget);
    expect(find.text('ログアウト'), findsOneWidget);
    expect(find.text('Version'), findsOneWidget);
  }

  group('Testing the settings view.', () {
    testWidgets('Testing element of view.', (WidgetTester tester) async {
      when(_repository.getVersion())
          .thenAnswer((_) => Future.value('1.1.0.1(1.1.7.1)'));
      await tester.pumpWidget(setUpProviderScope());
      _verifyElementOfView();
      await tester.pump();
      expect(find.text('1.1.0.1(1.1.7.1)'), findsOneWidget);
      verify(_repository.getVersion());
    });
  });
}
