import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/repository/send_short_message_repository.dart';
import 'package:nomoca_flutter/presentation/authentication_view.dart';
import 'package:nomoca_flutter/presentation/sign_in_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/states/providers/send_short_message_provider.dart';

import 'sign_in_view_test.mocks.dart';

@GenerateMocks([SendShortMessageRepository])
void main() {
  final _repository = MockSendShortMessageRepository();

  tearDown(() {
    reset(_repository);
  });

  ProviderScope setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // SMS送信APIを実行
        sendShortMessageRepositoryProvider.overrideWithValue(_repository),
      ],
      child: MaterialApp(
        // 初期表示画面設定
        home: SignInView(),
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('ログイン'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  }

  group('Testing sign in view.', () {
    testWidgets('Test for tapped of submit button of sending short message.',
        (WidgetTester tester) async {
      // APIレスポンスの戻り値を設定。
      when(_repository.sendShortMessage(
              mobilePhoneNumber: anyNamed('mobilePhoneNumber')))
          .thenAnswer((_) => Future.value());
      // View widgetビルド
      await tester.pumpWidget(setUpProviderScope());
      // 画面表示要素チェック
      _verifyElementOfView();
      // TextFormFieldに文字入力
      const verifyMobilePhoneNumber = '09012345678';
      await tester.enterText(
          find.byType(TextFormField), verifyMobilePhoneNumber);
      // ボタンタップ
      await tester.tap(find.byType(OutlinedButton));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移後画面要素確認
      expect(find.text('確認コード入力'), findsOneWidget);
      expect(find.text('確認コードを'), findsOneWidget);
      expect(find.text(verifyMobilePhoneNumber), findsOneWidget);
      expect(find.text('へ送信しました。'), findsOneWidget);
      expect(find.text('続けるには4桁の確認コードを入力してください。'), findsOneWidget);
      // Mockの呼び出しを検証
      verify(_repository.sendShortMessage(
          mobilePhoneNumber: verifyMobilePhoneNumber));
    });
  });

  group('Testing error of sign in view.', () {
    testWidgets('Test for error widget of exception.',
        (WidgetTester tester) async {
      // APIレスポンスの戻り値を設定。
      when(_repository.sendShortMessage(
              mobilePhoneNumber: anyNamed('mobilePhoneNumber')))
          .thenThrow(Exception('Error message.'));
      // View widgetビルド
      await tester.pumpWidget(setUpProviderScope());
      // 画面表示要素チェック
      _verifyElementOfView();
      // TextFormFieldに文字入力
      const verifyMobilePhoneNumber = '09012345678';
      await tester.enterText(
          find.byType(TextFormField), verifyMobilePhoneNumber);
      // ボタンタップ
      await tester.tap(find.byType(OutlinedButton));
      // SnackBar表示まで待機
      await tester.pumpAndSettle();
      // SnackBar表示確認
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: Error message.'), findsOneWidget);
      // Mockの呼び出しを検証
      verify(_repository.sendShortMessage(
          mobilePhoneNumber: verifyMobilePhoneNumber));
    });
  });
}
