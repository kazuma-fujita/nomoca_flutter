import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_notification_list_repository.dart';
import 'package:nomoca_flutter/data/repository/update_read_post_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/notification_detail_view.dart';
import 'package:nomoca_flutter/presentation/notification_list_view.dart';
import 'package:nomoca_flutter/states/reducers/notification_list_reducer.dart';

import 'notification_list_integration_test.mocks.dart';

@GenerateMocks([
  FetchNotificationListRepository,
  UpdateReadPostRepository,
])
void main() {
  final _listRepository = MockFetchNotificationListRepository();
  final _updateReadPostRepository = MockUpdateReadPostRepository();

  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  tearDown(() {
    reset(_listRepository);
    reset(_updateReadPostRepository);
  });

  ProviderScope _setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // 一覧画面の初期状態を設定
        fetchNotificationListRepositoryProvider
            .overrideWithValue(_listRepository),
        // 既読APIレスポンスの戻り値を設定
        updateReadPostRepositoryProvider
            .overrideWithValue(_updateReadPostRepository),
      ],
      child: MaterialApp(
        home: NotificationListView(),
        routes: <String, WidgetBuilder>{
          RouteNames.notificationDetail: (_) => NotificationDetailView(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }

  Future<void> _verifyTheStatusBeforeAfterLoading(WidgetTester tester) async {
    // 画面要素チェック
    expect(find.text('お知らせ'), findsOneWidget);
    // ローディング表示を確認
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Widgetがレンダリング完了するまで処理を待機
    await tester.pump();
    // エラー、ローディング非表示を確認
    expect(find.byType(ErrorSnackBar), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  }

  group('Testing notification list view and notification detail view.', () {
    testWidgets('Testing empty data view.', (WidgetTester tester) async {
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer((_) async => []);
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 空データ文言を確認
      expect(find.text('お知らせがありません'), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verifyNever(_updateReadPostRepository.updateReadPost(
          notificationId: anyNamed('notificationId')));
    });

    testWidgets('Testing update read post.', (WidgetTester tester) async {
      const contentsBaseUrl = 'https://contents-debug.nomoca.com';
      const responseData = [
        NotificationEntity(
          id: 140188,
          isRead: false,
          detail: NotificationDetailEntity(
              title: 'お知らせTitle1',
              body: 'お知らせBody1',
              contributor: 'テストクリニックからのお知らせ',
              deliveryDate: '2021/06/21 12:15',
              // imageUrl: null),
              imageUrl:
                  '$contentsBaseUrl/institutions/140188/image1/381e52949a3fb4ce444a6de59c8e1190.jpg'),
        ),
        NotificationEntity(
          id: 141338,
          isRead: false,
          detail: NotificationDetailEntity(
              title: 'お知らせTitle2',
              // ignore: lines_longer_than_80_chars
              body: 'お知らせBody2',
              contributor: 'テスト歯科からのお知らせ',
              deliveryDate: '2021/05/01 09:05',
              // imageUrl: null),
              imageUrl:
                  '$contentsBaseUrl/institutions/141338/image1/a35d6ac6ad8258db2891a1bc69ae8c1b.jpg'),
        ),
      ];
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer((_) async => responseData);
      // お知らせ既読APIレスポンスデータを設定
      when(_updateReadPostRepository.updateReadPost(
              notificationId: anyNamed('notificationId')))
          .thenAnswer((_) async => Future.value());
      // 一覧画面をレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 一覧リスト要素を確認。未読状態のFontWeight.boldを確認
      final title1Finder = find.text('お知らせTitle1');
      var title1 = tester.firstWidget(title1Finder) as Text;
      final date1Finder = find.text('2021/06/21 12:15');
      var date1 = tester.firstWidget(title1Finder) as Text;
      final title2Finder = find.text('お知らせTitle2');
      var title2 = tester.firstWidget(title2Finder) as Text;
      final date2Finder = find.text('2021/05/01 09:05');
      var date2 = tester.firstWidget(title2Finder) as Text;
      expect(title1Finder, findsOneWidget);
      expect(title1.style!.fontWeight, FontWeight.bold);
      expect(title1.maxLines, 1);
      expect(title1.overflow, TextOverflow.ellipsis);
      expect(date1Finder, findsOneWidget);
      expect(date1.style!.fontWeight, FontWeight.bold);
      expect(title2Finder, findsOneWidget);
      expect(title2.style!.fontWeight, FontWeight.bold);
      expect(title2.maxLines, 1);
      expect(title2.overflow, TextOverflow.ellipsis);
      expect(date2Finder, findsOneWidget);
      expect(date2.style!.fontWeight, FontWeight.bold);
      expect(find.byType(CircleAvatar), findsNWidgets(2));
      // 一覧要素をタップ
      await tester.tap(title1Finder);
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移先画面の要素チェック
      expect(find.text('テストクリニックからのお知らせ'), findsOneWidget);
      expect(find.text('お知らせTitle1'), findsOneWidget);
      expect(find.text('2021/06/21 12:15'), findsOneWidget);
      expect(find.text('お知らせBody1'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byTooltip('Back'), findsOneWidget);
      // 戻るボタンタップ
      await tester.tap(find.byTooltip('Back'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 一覧リスト要素を確認。お知らせTitle1が既読状態FontWeight.normalであることを確認
      title1 = tester.firstWidget(title1Finder) as Text;
      date1 = tester.firstWidget(date1Finder) as Text;
      title2 = tester.firstWidget(title2Finder) as Text;
      date2 = tester.firstWidget(date2Finder) as Text;
      expect(title1Finder, findsOneWidget);
      expect(title1.style!.fontWeight, FontWeight.normal);
      expect(date1Finder, findsOneWidget);
      expect(date1.style!.fontWeight, FontWeight.normal);
      expect(title2Finder, findsOneWidget);
      expect(title2.style!.fontWeight, FontWeight.bold);
      expect(date2Finder, findsOneWidget);
      expect(date2.style!.fontWeight, FontWeight.bold);
      expect(find.byType(CircleAvatar), findsNWidgets(2));
      // 一覧要素をタップ
      await tester.tap(title2Finder);
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 遷移先画面の要素チェック
      expect(find.text('テスト歯科からのお知らせ'), findsOneWidget);
      expect(find.text('お知らせTitle2'), findsOneWidget);
      expect(find.text('2021/05/01 09:05'), findsOneWidget);
      expect(find.text('お知らせBody2'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byTooltip('Back'), findsOneWidget);
      // 戻るボタンタップ
      await tester.tap(find.byTooltip('Back'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 一覧リスト要素を確認。お知らせTitle1、2が既読状態FontWeight.normalであることを確認
      title1 = tester.firstWidget(title1Finder) as Text;
      date1 = tester.firstWidget(date1Finder) as Text;
      title2 = tester.firstWidget(title2Finder) as Text;
      date2 = tester.firstWidget(date2Finder) as Text;
      expect(title1Finder, findsOneWidget);
      expect(title1.style!.fontWeight, FontWeight.normal);
      expect(date1Finder, findsOneWidget);
      expect(date1.style!.fontWeight, FontWeight.normal);
      expect(title2Finder, findsOneWidget);
      expect(title2.style!.fontWeight, FontWeight.normal);
      expect(date2Finder, findsOneWidget);
      expect(date2.style!.fontWeight, FontWeight.normal);
      expect(find.byType(CircleAvatar), findsNWidgets(2));
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_updateReadPostRepository.updateReadPost(
              notificationId: anyNamed('notificationId')))
          .called(2);
    });
  });
}
