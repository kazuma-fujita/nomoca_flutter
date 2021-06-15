import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

void main() {
  ProviderScope setUpProviderScope(
      Future<List<UserNicknameEntity>> futureValue, Override futureProvider) {
    return ProviderScope(
      overrides: [
        // create or update future provider of family user.
        futureProvider,
        // 家族一覧画面の初期状態を設定
        familyUserListState
            .overrideWithProvider(StateProvider((ref) => futureValue)),
        // 家族アカウント追加・更新・削除時に診察券画面のデータ再取得実行
        patientCardState.overrideWithValue(const AsyncData([])),
      ],
      child: MaterialApp(
        home: FamilyUserListView(),
        routes: <String, WidgetBuilder>{
          RouteNames.upsertUser: (_) => UpsertUserView(),
        },
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

  group('Testing the family user list view.', () {
    testWidgets('Created user of family.', (WidgetTester tester) async {
      // 家族アカウント作成APIレスポンスデータを設定
      final futureProvider = createFamilyUserProvider.overrideWithProvider(
          (ref, param) =>
              Future.value(const UserNicknameEntity(id: 1237, nickname: '花子')));
      // 空データ配列で家族アカウント一覧画面を描写
      await tester
          .pumpWidget(setUpProviderScope(Future.value([]), futureProvider));
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
    });

    testWidgets('Updated user of family.', (WidgetTester tester) async {
      final futureProvider = updateFamilyUserProvider.overrideWithProvider(
          (ref, param) =>
              Future.value(const UserNicknameEntity(id: 1237, nickname: '次郎')));
      await tester.pumpWidget(setUpProviderScope(
          Future.value([const UserNicknameEntity(id: 1237, nickname: '花子')]),
          futureProvider));
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
    });
  });
}
