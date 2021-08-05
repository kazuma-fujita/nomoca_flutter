import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';
import 'package:nomoca_flutter/presentation/sign_in_view.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';

void main() {
  ProviderScope setUpProviderScope(AsyncValue<UserNicknameEntity> asyncValue) {
    return ProviderScope(
      overrides: [
        // ニックネームをDBから取得
        userManagementProvider.overrideWithValue(asyncValue),
      ],
      child: MaterialApp(
        home: const UserManagementView(),
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
      const user = UserNicknameEntity(id: 1, nickname: '太郎');
      await tester.pumpWidget(setUpProviderScope(const AsyncValue.data(user)));
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
