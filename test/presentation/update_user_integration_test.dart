import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_patient_cards_repository.dart';
import 'package:nomoca_flutter/data/repository/update_user_repository.dart';
import 'package:nomoca_flutter/data/repository/user_management_repository.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/providers/update_user_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';

import 'update_user_integration_test.mocks.dart';

@GenerateMocks([
  UserManagementRepository,
  UpdateUserRepository,
  FetchPatientCardsRepository
])
void main() {
  late MockUserManagementRepository _userManagementRepository;
  late MockUpdateUserRepository _updateUserRepository;
  late MockFetchPatientCardsRepository _patientCardRepository;

  setUp(() {
    _userManagementRepository = MockUserManagementRepository();
    _updateUserRepository = MockUpdateUserRepository();
    _patientCardRepository = MockFetchPatientCardsRepository();
  });

  ProviderScope setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // ニックネームをDBから取得
        userManagementRepositoryProvider
            .overrideWithValue(_userManagementRepository),
        // ニックニーム更新APIを実行
        updateUserRepositoryProvider.overrideWithValue(_updateUserRepository),
        // ニックネーム変更時に診察券画面のデータ再取得実行
        patientCardRepositoryProvider.overrideWithValue(_patientCardRepository),
      ],
      child: const MaterialApp(
        // 初期表示画面設定
        home: UserManagementView(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('家族アカウント管理'), findsOneWidget);
    expect(find.text('診察券登録'), findsOneWidget);
    expect(find.text('設定'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  }

  group('Testing integration of user management view and upsert user view.',
      () {
    testWidgets('Testing update of user nickname.',
        (WidgetTester tester) async {
      // DBから取得するニックネームのStabデータ。Mockがcallされる回数分設定
      final results = [
        const UserNicknameEntity(id: 1234, nickname: '太郎'),
        const UserNicknameEntity(id: 1234, nickname: '次郎'),
      ];
      // repository.getUser()はプロフィール画面表示、プロフィール更新時と2回callされる。
      when(_userManagementRepository.getUser())
          .thenAnswer((_) => results.removeAt(0));
      // updateUser()はプロフィール更新APIを実行する。APIレスポンスの戻り値を設定。
      when(_updateUserRepository.updateUser(
              userId: anyNamed('userId'), nickname: anyNamed('nickname')))
          .thenAnswer(
              (_) async => const UserNicknameEntity(id: 1234, nickname: '次郎'));
      // プロフィール更新後、診察券画面更新を行う。APIレスポンスの戻り値を設定。
      when(_patientCardRepository.fetchList()).thenAnswer((_) async => []);
      // プロフィール画面Widgetビルド
      await tester.pumpWidget(setUpProviderScope());
      // DBからニックネーム取得完了するまで処理を待機
      await tester.pump();
      // プロフィール画面表示要素チェック
      _verifyElementOfView();
      expect(find.text('ようこそ太郎さん'), findsOneWidget);
      // プロフィール編集ボタンタップ
      await tester.tap(find.byType(ElevatedButton));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移後画面要素確認
      expect(find.text('プロフィール編集'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('太郎'), findsOneWidget);
      // TextFormFieldに文字入力
      await tester.enterText(find.byType(TextFormField), '次郎');
      // 保存ボタンタップ
      await tester.tap(find.byType(ElevatedButton));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // ニックネームが変更されたことを確認
      expect(find.text('ようこそ次郎さん'), findsOneWidget);
      // Mockの呼び出しを検証
      verify(_userManagementRepository.getUser()).called(2);
      verify(_updateUserRepository.updateUser(
          userId: anyNamed('userId'), nickname: anyNamed('nickname')));
      verify(_patientCardRepository.fetchList());
    });
  });
}
