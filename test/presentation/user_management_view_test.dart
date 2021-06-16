import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/presentation/sign_in_view.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';

void main() {
  ProviderScope setUpProviderScope(AsyncValue<User> asyncValue) {
    return ProviderScope(
      overrides: [
        // 家族アカウント追加・更新・削除時に診察券画面のデータ再取得実行
        userManagementViewState.overrideWithValue(asyncValue),
      ],
      child: MaterialApp(
        home: UserManagementView(),
        routes: <String, WidgetBuilder>{
          RouteNames.signIn: (_) => SignInView(),
        },
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('家族アカウント管理'), findsOneWidget);
    expect(find.text('診察券登録'), findsOneWidget);
    expect(find.text('設定'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  }

  group('Testing the user management view.', () {
    testWidgets('Testing element of view.', (WidgetTester tester) async {
      final user = User()
        ..userId = 1
        ..nickname = '太郎';
      await tester.pumpWidget(setUpProviderScope(AsyncValue.data(user)));
      _verifyElementOfView();
      expect(find.text('ようこそ太郎さん'), findsOneWidget);
    });

    testWidgets('Testing error of authentication.',
        (WidgetTester tester) async {
      // 認証エラーを発生させてログイン画面へ遷移
      await tester.pumpWidget(
          setUpProviderScope(AsyncValue.error(AuthenticationError())));
      // 遷移先画面Widgetがレンダリングし終わるまで待機
      await tester.pumpAndSettle();
      expect(find.text('ログイン'), findsOneWidget);
    });
  });
}
