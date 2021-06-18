import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/delete_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

import 'family_user_integration_test.mocks.dart';

@GenerateMocks([
  CreateFamilyUserRepository,
  UpdateFamilyUserRepository,
  DeleteFamilyUserRepository,
  FetchFamilyUserListRepository,
  PatientCardRepository,
])
void main() {
  final _listRepository = MockFetchFamilyUserListRepository();
  final _createRepository = MockCreateFamilyUserRepository();
  final _updateRepository = MockUpdateFamilyUserRepository();
  final _deleteRepository = MockDeleteFamilyUserRepository();
  final _patientCardRepository = MockPatientCardRepository();

  tearDown(() {
    reset(_listRepository);
    reset(_createRepository);
    reset(_updateRepository);
    reset(_deleteRepository);
    reset(_patientCardRepository);
  });

  ProviderScope setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // 家族一覧画面の初期状態を設定
        fetchFamilyUserListRepositoryProvider
            .overrideWithValue(_listRepository),
        // 家族アカウント追加・更新・削除時のAPIレスポンスの戻り値を設定
        createFamilyUserRepositoryProvider.overrideWithValue(_createRepository),
        updateFamilyUserRepositoryProvider.overrideWithValue(_updateRepository),
        deleteFamilyUserRepositoryProvider.overrideWithValue(_deleteRepository),
        // 家族アカウント追加・更新・削除時に診察券画面のデータ再取得実行
        patientCardRepositoryProvider.overrideWithValue(_patientCardRepository),
      ],
      child: MaterialApp(
        home: FamilyUserListView(),
        routes: <String, WidgetBuilder>{
          RouteNames.upsertUser: (_) => UpsertUserView(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }

  Future<void> _verifyTheStatusBeforeAfterLoading(WidgetTester tester) async {
    // 画面要素チェック
    expect(find.text('家族アカウント管理'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    // ローディング表示を確認
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Widgetがレンダリング完了するまで処理を待機
    await tester.pump();
    // エラー、ローディング非表示を確認
    expect(find.byType(ErrorSnackBar), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  }

  group('Testing the family user list view and the upsert user view.', () {
    testWidgets('Testing create user of family.', (WidgetTester tester) async {
      // 家族アカウント一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer((_) async => []);
      // 家族アカウント作成APIレスポンスデータを設定
      when(_createRepository.createUser(nickname: anyNamed('nickname')))
          .thenAnswer(
              (_) async => const UserNicknameEntity(id: 1237, nickname: '花子'));
      // アカウント作成後、診察券画面更新を行う。APIレスポンスの戻り値を設定。
      when(_patientCardRepository.fetchList()).thenAnswer((_) async => []);
      // 空データ配列で家族アカウント一覧画面をレンダリング
      await tester.pumpWidget(setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 空データ時の文言チェック
      expect(find.text('家族アカウントを登録しましょう'), findsOneWidget);
      // アカウント追加ボタンをタップ
      await tester.tap(find.byIcon(Icons.add));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移先画面の要素チェック
      expect(find.text('家族アカウント作成'), findsOneWidget);
      // TextFormFieldに文字入力
      await tester.enterText(find.byType(TextFormField), '花子');
      // 保存ボタンタップ
      await tester.tap(find.byType(ElevatedButton));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 家族一覧に要素が追加されたことを確認
      expect(find.text('家族アカウント管理'), findsOneWidget);
      expect(find.text('花子'), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_createRepository.createUser(nickname: anyNamed('nickname')));
      verify(_patientCardRepository.fetchList());
    });

    testWidgets('Testing update user of family.', (WidgetTester tester) async {
      // 家族アカウント一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer(
          (_) async => [const UserNicknameEntity(id: 1237, nickname: '花子')]);
      // 家族アカウント更新APIレスポンスデータを設定
      when(_updateRepository.updateUser(
              familyUserId: anyNamed('familyUserId'),
              nickname: anyNamed('nickname')))
          .thenAnswer(
              (_) async => const UserNicknameEntity(id: 1237, nickname: '次郎'));
      // アカウント更新後、診察券画面更新を行う。APIレスポンスの戻り値を設定。
      when(_patientCardRepository.fetchList()).thenAnswer((_) async => []);
      // 配列要素が一つの家族一覧画面Widgetをレンダリング
      await tester.pumpWidget(setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 一覧に一つの要素が表示されていることを確認
      expect(find.text('花子'), findsOneWidget);
      // 一覧の要素をタップ
      await tester.tap(find.text('花子'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移先の画面要素確認
      expect(find.text('家族アカウント編集'), findsOneWidget);
      expect(find.text('花子'), findsOneWidget);
      // TextFormFieldに文字入力
      await tester.enterText(find.byType(TextFormField), '次郎');
      // 保存ボタンタップ
      await tester.tap(find.byType(ElevatedButton));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 家族一覧の要素が更新されたことを確認
      expect(find.text('家族アカウント管理'), findsOneWidget);
      expect(find.text('次郎'), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_updateRepository.updateUser(
          familyUserId: anyNamed('familyUserId'),
          nickname: anyNamed('nickname')));
      verify(_patientCardRepository.fetchList());
    });

    testWidgets('Testing delete user of family.', (WidgetTester tester) async {
      // 家族アカウント一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer(
          (_) async => [const UserNicknameEntity(id: 1237, nickname: '花子')]);
      // 家族アカウント削除APIレスポンスデータを設定
      when(_deleteRepository.deleteUser(familyUserId: anyNamed('familyUserId')))
          .thenAnswer((_) async => Future.value());
      // 配列要素が一つの家族一覧画面Widgetをレンダリング
      await tester.pumpWidget(setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 一覧に一つの要素が表示されていることを確認
      expect(find.text('花子'), findsOneWidget);
      // 一覧の要素をスワイプ
      await tester.drag(find.byType(Dismissible), const Offset(500, 0));
      // Widgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 削除確認ダイアログ表示チェック
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      // OKボタンをタップ
      await tester.tap(find.text('OK'));
      // Widgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 削除確認ダイアログ非表示チェック
      expect(find.byType(AlertDialog), findsNothing);
      // 一覧画面の要素が削除されていることを確認
      expect(find.text('花子'), findsNothing);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(
          _deleteRepository.deleteUser(familyUserId: anyNamed('familyUserId')));
      verifyNever(_patientCardRepository.fetchList());
    });
  });
}
