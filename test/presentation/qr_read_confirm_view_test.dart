import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/preview_cards_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/registration_card_repository.dart';
import 'package:nomoca_flutter/data/repository/user_management_repository.dart';
import 'package:nomoca_flutter/presentation/arguments/qr_read_confirm_argument.dart';
import 'package:nomoca_flutter/presentation/qr_read_confirm_view.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/states/providers/registration_card_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';

import 'qr_read_confirm_view_test.mocks.dart';

@GenerateMocks([RegistrationCardRepository, UserManagementRepository])
void main() {
  final _repository = MockRegistrationCardRepository();
  final _userManagementRepository = MockUserManagementRepository();

  tearDown(() {
    reset(_repository);
    reset(_userManagementRepository);
  });

  ProviderScope setUpProviderScope(QrReadConfirmArgument? args) {
    return ProviderScope(
      overrides: [
        registrationCardRepositoryProvider.overrideWithValue(_repository),
        userManagementRepositoryProvider
            .overrideWithValue(_userManagementRepository),
      ],
      child: MaterialApp(
        // 初期表示画面設定
        home: QrReadConfirmView(args: args),
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('診察券登録'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('登録'), findsOneWidget);
    // エラー、ローディング非表示を確認
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(EasyLoading), findsNothing);
  }

  group('Testing registration card view.', () {
    testWidgets('Test for tapped of submit button of card registration.',
        (WidgetTester tester) async {
      // 診察券登録画面の引数に渡すオブジェクト
      const previewCards = PreviewCardsEntity(sourceUserId: 123, patients: [
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
            institutionName: '渋谷デンタルクリニック',
          ),
        )
      ]);
      const args =
          QrReadConfirmArgument(entity: previewCards, familyUserId: null);
      // 診察券登録APIレスポンスの戻り値を設定
      when(_repository.registration(
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      )).thenAnswer((_) => Future.value());
      // プロフィール画面に表示するニックネームをモッキング
      when(_userManagementRepository.getUser())
          .thenReturn(const UserNicknameEntity(id: 1234, nickname: '太郎'));
      // View widgetビルド
      await tester.pumpWidget(setUpProviderScope(args));
      // 画面表示要素チェック
      _verifyElementOfView();
      expect(find.text('田中歯科'), findsOneWidget);
      expect(find.text('渋谷デンタルクリニック'), findsOneWidget);
      expect(find.text('ｻﾄｳ ﾀﾛｳ  診察券番号 12345'), findsOneWidget);
      expect(find.text('ｻﾄｳ ﾀﾛｳ  診察券番号 6789012345'), findsOneWidget);
      // ボタンタップ
      await tester.tap(find.byType(TextButton));
      // Loaderの確認ができない
      // expect(find.byType(EasyLoading), findsOneWidget);
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移後画面要素確認
      expect(find.text('ようこそ太郎さん'), findsOneWidget);
      expect(find.text('家族アカウント管理'), findsOneWidget);
      expect(find.text('診察券登録'), findsOneWidget);
      expect(find.text('設定'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('診察券を登録しました'), findsOneWidget);
      // Mockの呼び出しを検証
      verify(_repository.registration(
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      ));
      verify(_userManagementRepository.getUser());
    });
  });

  // 単体でこのテストは通る。
  // mainで複数のテストを実行すると何故かmokitoでCannot call `when` within a stub responseでエラーになる
  group('Testing error of qr read confirm view.', () {
    testWidgets('Test for error widget of exception.',
        (WidgetTester tester) async {
      // 診察券登録APIレスポンスの戻り値を設定
      when(_repository.registration(
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      )).thenThrow(Exception('Error message.'));
      // 診察券登録画面の引数に渡すオブジェクト
      const previewCards = PreviewCardsEntity(sourceUserId: 123, patients: [
        PreviewCardPatientEntity(
          nameKana: 'ｻﾄｳ ﾀﾛｳ',
          localId: '12345',
          institution: PreviewCardInstitutionEntity(
            institutionId: 1234,
            institutionName: '田中歯科',
          ),
        ),
      ]);
      const args =
          QrReadConfirmArgument(entity: previewCards, familyUserId: null);
      // View widgetビルド
      await tester.pumpWidget(setUpProviderScope(args));
      // 画面表示要素チェック
      _verifyElementOfView();
      expect(find.text('田中歯科'), findsOneWidget);
      expect(find.text('ｻﾄｳ ﾀﾛｳ  診察券番号 12345'), findsOneWidget);
      // ボタンタップ
      await tester.tap(find.byType(TextButton));
      // SnackBar表示まで待機
      await tester.pumpAndSettle();
      // SnackBar表示確認
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: Error message.'), findsOneWidget);
      // Mockの呼び出しを検証
      verify(_repository.registration(
        sourceUserId: anyNamed('sourceUserId'),
        familyUserId: anyNamed('familyUserId'),
      ));
    });
  });
}
