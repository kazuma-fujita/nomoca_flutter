import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart';
import 'package:nomoca_flutter/data/repository/update_next_reserve_date_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/providers/update_next_reserve_date_provider.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'favorite_list_view_next_reserve_date_dialog_test.mocks.dart';

@GenerateMocks([
  UpdateNextReserveDateRepository,
  FetchFavoriteListRepository,
  GetFavoritePatientCardRepository,
  UpdateFavoriteRepository,
])
void main() {
  final _updateReserveDateRepository = MockUpdateNextReserveDateRepository();
  final _listRepository = MockFetchFavoriteListRepository();
  final _patientCardRepository = MockGetFavoritePatientCardRepository();
  final _updateFavoriteRepository = MockUpdateFavoriteRepository();

  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  tearDown(() {
    reset(_listRepository);
    reset(_patientCardRepository);
    reset(_updateFavoriteRepository);
  });

  ProviderScope _setUpProviderScope() {
    return ProviderScope(
      overrides: [
        updateNextReserveDateRepositoryProvider
            .overrideWithValue(_updateReserveDateRepository),
        fetchFavoriteListRepositoryProvider.overrideWithValue(_listRepository),
        getFavoritePatientCardRepositoryProvider
            .overrideWithValue(_patientCardRepository),
        updateFavoriteRepositoryProvider
            .overrideWithValue(_updateFavoriteRepository),
      ],
      child: MaterialApp(
        home: FavoriteListView(),
        // locale設定
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // localeに英語と日本語を登録
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        // アプリのlocaleを日本語に変更
        locale: const Locale('ja', 'JP'),
      ),
    );
  }

  Future<void> _verifyTheStatusBeforeAfterLoading(WidgetTester tester) async {
    // ローディング表示を確認
    expect(find.byType(Shimmer), findsOneWidget);
    // Widgetがレンダリング完了するまで処理を待機
    await tester.pump();
    // 画面要素チェック
    expect(find.text('かかりつけ'), findsOneWidget);
    // 診察券カードがレンダリング完了するまで処理を待機
    await tester.pump();
    // エラー、ローディング非表示を確認
    expect(find.byType(ErrorSnackBar), findsNothing);
    expect(find.byType(Shimmer), findsNothing);
  }

  group('next reserve date dialog tests', () {
    testWidgets('Test creating reserve date.', (WidgetTester tester) async {
      final entities = [
        const FavoriteEntity(
          institutionId: 92506,
          type: 'clinic',
          name: '渋谷リーフクリニック',
          images: null,
          userIds: [199],
        ),
      ];
      const patientCard = FavoritePatientCardEntity(
        institutionId: 92506,
        userId: 199,
        nickname: '太郎',
        localId: null,
        reserveDate: null,
        lastReceptionDate: null,
        isPatient: false,
      );
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer((_) async => entities);
      // 診察券カードAPIレスポンスデータを設定
      when(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      )).thenAnswer((_) async => patientCard);

      final nowDate = DateTime.now();
      final yyyyMMdd = DateFormat('yyyy/MM/dd').format(nowDate);
      final requestDate = DateFormat('yyyy-MM-dd HH:mm').format(nowDate);

      when(_updateReserveDateRepository.updateNextReserveDate(
        institutionId: 92506,
        userId: 199,
        reserveDate: requestDate,
      )).thenAnswer((_) => Future.value());
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      // 画面要素、ローディング表示を確認
      await _verifyTheStatusBeforeAfterLoading(tester);
      // レンダリング後の画面要素を確認
      expect(find.byType(Image), findsNWidgets(1));
      expect(find.text('渋谷リーフクリニック'), findsOneWidget);
      // 診察券カード要素確認
      expect(find.text('太郎の診察券'), findsOneWidget);
      expect(find.text('診察券番号'), findsOneWidget);
      expect(find.text('診察券番号を入力してください'), findsOneWidget);
      expect(find.text('次回予約日時メモ'), findsOneWidget);
      expect(find.text('次回予約日時メモを入力してください'), findsOneWidget);
      expect(find.text('前回受付'), findsOneWidget);
      expect(find.text('---- / -- / --  -- : --'), findsOneWidget);
      // TextField要素確認
      final nextReserveDateTextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-92506199'));
      final nextReserveDateTextField =
          tester.firstWidget(nextReserveDateTextFieldFinder) as TextField;
      expect(nextReserveDateTextFieldFinder, findsOneWidget);
      expect(nextReserveDateTextField.controller!.text, isEmpty);
      // 診察券カードを全て表示させる為ListViewを画面下部にスクロール
      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pump();
      // TextFieldをタップしてダイアログ表示
      await tester.tap(nextReserveDateTextFieldFinder);
      await tester.pump();
      // 登録ダイアログ表示確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('予約日'), findsOneWidget);
      expect(find.text('時刻'), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
      // 当日の日付が設定されていること
      expect(find.text(yyyyMMdd), findsOneWidget);
      final nextReserveDateDialogTextFieldFinder = find
          .byKey(const Key('nextReserveDate-dialog-DateTimePicker-92506199'));
      expect(nextReserveDateDialogTextFieldFinder, findsOneWidget);
      // DateTimePickerを開く
      await tester.tap(nextReserveDateDialogTextFieldFinder);
      await tester.pump();
      // 日付選択で当日の日付が選択されていることを確認
      expect(find.text(nowDate.day.toString()), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('キャンセル'), findsNWidgets(2));
      await tester.tap(find.text('OK'));
      await tester.pump();
      expect(find.text(yyyyMMdd), findsOneWidget);
      // 保存ボタンタップ
      await tester.tap(find.text('保存'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_updateReserveDateRepository.updateNextReserveDate(
        institutionId: 92506,
        userId: 199,
        reserveDate: requestDate,
      ));
    });

    group('Local id dialog error tests', () {
      testWidgets('Testing display of error.', (WidgetTester tester) async {
        final entities = [
          const FavoriteEntity(
            institutionId: 92506,
            type: 'clinic',
            name: '渋谷リーフクリニック',
            images: null,
            userIds: [199],
          ),
        ];
        const patientCard = FavoritePatientCardEntity(
          institutionId: 92506,
          userId: 199,
          nickname: '太郎',
          localId: null,
          reserveDate: null,
          lastReceptionDate: null,
          isPatient: false,
        );
        // 一覧APIレスポンスデータを設定
        when(_listRepository.fetchList()).thenAnswer((_) async => entities);
        // 診察券カードAPIレスポンスデータを設定
        when(_patientCardRepository.get(
          userId: anyNamed('userId'),
          institutionId: anyNamed('institutionId'),
        )).thenAnswer((_) async => patientCard);

        final nowDate = DateTime.now();
        final yyyyMMdd = DateFormat('yyyy/MM/dd').format(nowDate);
        final requestDate = DateFormat('yyyy-MM-dd HH:mm').format(nowDate);

        when(_updateReserveDateRepository.updateNextReserveDate(
          institutionId: 92506,
          userId: 199,
          reserveDate: requestDate,
        )).thenThrow(Exception('Error message.'));

        // 一覧画面Widgetをレンダリング
        await tester.pumpWidget(_setUpProviderScope());
        // 画面要素、ローディング表示を確認
        await _verifyTheStatusBeforeAfterLoading(tester);
        // レンダリング後の画面要素を確認
        expect(find.byType(Image), findsNWidgets(1));
        expect(find.text('渋谷リーフクリニック'), findsOneWidget);
        // 診察券カード要素確認
        expect(find.text('太郎の診察券'), findsOneWidget);
        expect(find.text('診察券番号'), findsOneWidget);
        expect(find.text('診察券番号を入力してください'), findsOneWidget);
        expect(find.text('次回予約日時メモ'), findsOneWidget);
        expect(find.text('次回予約日時メモを入力してください'), findsOneWidget);
        expect(find.text('前回受付'), findsOneWidget);
        expect(find.text('---- / -- / --  -- : --'), findsOneWidget);
        // TextField要素確認
        final nextReserveDateTextFieldFinder =
            find.byKey(const Key('nextReserveDate-TextField-92506199'));
        final nextReserveDateTextField =
            tester.firstWidget(nextReserveDateTextFieldFinder) as TextField;
        expect(nextReserveDateTextFieldFinder, findsOneWidget);
        expect(nextReserveDateTextField.controller!.text, isEmpty);
        // 診察券カードを全て表示させる為ListViewを画面下部にスクロール
        await tester.drag(find.byType(ListView), const Offset(0, -800));
        await tester.pump();
        // TextFieldをタップしてダイアログ表示
        await tester.tap(nextReserveDateTextFieldFinder);
        await tester.pump();
        // ダイアログ表示確認
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('予約日'), findsOneWidget);
        expect(find.text('時刻'), findsOneWidget);
        expect(find.text('キャンセル'), findsOneWidget);
        expect(find.text('保存'), findsOneWidget);
        // 当日の日付が設定されていること
        expect(find.text(yyyyMMdd), findsOneWidget);
        final nextReserveDateDialogTextFieldFinder = find
            .byKey(const Key('nextReserveDate-dialog-DateTimePicker-92506199'));
        expect(nextReserveDateDialogTextFieldFinder, findsOneWidget);
        // DateTimePickerを開く
        await tester.tap(nextReserveDateDialogTextFieldFinder);
        await tester.pump();
        // 日付選択で当日の日付が選択されていることを確認
        expect(find.text(nowDate.day.toString()), findsOneWidget);
        expect(find.text('OK'), findsOneWidget);
        expect(find.text('キャンセル'), findsNWidgets(2));
        await tester.tap(find.text('OK'));
        await tester.pump();
        expect(find.text(yyyyMMdd), findsOneWidget);
        // 保存ボタンタップ
        await tester.tap(find.text('保存'));
        // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
        await tester.pumpAndSettle();
        // Error widget表示確認
        expect(find.byType(SnackBar), findsOneWidget);
        // エラー文言を確認
        expect(find.text('Exception: Error message.'), findsOneWidget);
        // キャンセルボタンタップ
        await tester.tap(find.text('キャンセル'));
        // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
        await tester.pumpAndSettle();
        // 再度TextFieldをタップしてダイアログ表示
        await tester.tap(nextReserveDateTextFieldFinder);
        await tester.pump();
        // 当日の日付が設定されていること
        expect(find.text(yyyyMMdd), findsOneWidget);
        // Mock呼び出しを検証
        verify(_listRepository.fetchList());
        verify(_patientCardRepository.get(
          userId: anyNamed('userId'),
          institutionId: anyNamed('institutionId'),
        ));
        verify(_updateReserveDateRepository.updateNextReserveDate(
          institutionId: 92506,
          userId: 199,
          reserveDate: requestDate,
        ));
      });
    });
  });
}
