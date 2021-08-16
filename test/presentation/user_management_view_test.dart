import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';

void main() {
  const user = UserNicknameEntity(id: 1, nickname: '太郎');

  ProviderScope setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // ニックネームをDBから取得
        userManagementProvider.overrideWithValue(const AsyncValue.data(user)),
      ],
      child: const MaterialApp(
        home: UserManagementView(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  void _verifyElementOfView() {
    expect(find.text('ようこそ太郎さん'), findsOneWidget);
    expect(find.text('家族アカウント管理'), findsOneWidget);
    expect(find.text('診察券登録'), findsOneWidget);
    expect(find.text('設定'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  }

  group('Testing user management view.', () {
    testWidgets('Testing transition of family user list view.',
        (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope());
      _verifyElementOfView();
      await tester.tap(find.text('家族アカウント管理'));
      await tester.pumpAndSettle();
      expect(find.text('家族アカウント管理'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Testing transition of read select user type view.',
        (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope());
      _verifyElementOfView();
      await tester.tap(find.text('診察券登録'));
      await tester.pumpAndSettle();
      expect(find.text('家族の診察券'), findsOneWidget);
      expect(find.text('自分の診察券'), findsOneWidget);
      expect(find.text('スキップする'), findsOneWidget);
    });

    testWidgets('Testing transition of settings view.',
        (WidgetTester tester) async {
      await tester.pumpWidget(setUpProviderScope());
      _verifyElementOfView();
      await tester.tap(find.text('設定'));
      await tester.pumpAndSettle();
      expect(find.text('設定'), findsOneWidget);
      expect(find.text('通知設定'), findsOneWidget);
      expect(find.text('利用規約'), findsOneWidget);
      expect(find.text('プライバシーポリシー'), findsOneWidget);
      expect(find.text('ログアウト'), findsOneWidget);
      expect(find.text('Version'), findsOneWidget);
    });
  });

  group('Testing error of user management view.', () {
    testWidgets('Testing error of authentication.',
        (WidgetTester tester) async {
      // 認証エラーを発生させてログイン画面へ遷移
      await tester.pumpWidget(ProviderScope(
        overrides: [
          userManagementProvider
              .overrideWithValue(AsyncValue.error(AuthenticationError())),
        ],
        child: const MaterialApp(
          home: UserManagementView(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ));
      // 遷移先画面Widgetがレンダリングし終わるまで待機
      await tester.pumpAndSettle();
      expect(find.text('例外エラーが発生しました'), findsOneWidget);
      expect(find.text(AuthenticationError.description), findsOneWidget);
    });
  });
}
