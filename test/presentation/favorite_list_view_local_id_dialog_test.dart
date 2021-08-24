import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart';
import 'package:nomoca_flutter/data/repository/update_local_id_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/providers/update_local_id_provider.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'favorite_list_view_local_id_dialog_test.mocks.dart';

@GenerateMocks([
  UpdateLocalIdRepository,
  FetchFavoriteListRepository,
  GetFavoritePatientCardRepository,
  UpdateFavoriteRepository,
])
void main() {
  final _updateLocalIdRepository = MockUpdateLocalIdRepository();
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
        updateLocalIdRepositoryProvider
            .overrideWithValue(_updateLocalIdRepository),
        fetchFavoriteListRepositoryProvider.overrideWithValue(_listRepository),
        getFavoritePatientCardRepositoryProvider
            .overrideWithValue(_patientCardRepository),
        updateFavoriteRepositoryProvider
            .overrideWithValue(_updateFavoriteRepository),
      ],
      child: MaterialApp(
        home: FavoriteListView(),
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

  group('Local id dialog tests', () {
    testWidgets('Test creating local id.', (WidgetTester tester) async {
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
      when(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
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
      final localIdTextFieldFinder =
          find.byKey(const Key('localId-TextField-92506199'));
      final localIdTextField =
          tester.firstWidget(localIdTextFieldFinder) as TextField;
      expect(localIdTextFieldFinder, findsOneWidget);
      expect(localIdTextField.controller!.text, isEmpty);
      // 診察券カードを全て表示させる為ListViewを画面下部にスクロール
      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pump();
      // TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号登録ダイアログ表示確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('診察券番号登録'), findsOneWidget);
      expect(find.text('診察券番号'), findsNWidgets(2));
      expect(find.text('診察券番号を入力してください'), findsNWidgets(2));
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
      // TextField要素確認
      final localIdDialogTextFieldFinder =
          find.byKey(const Key('localId-dialog-TextField-92506199'));
      final localIdDialogTextField =
          tester.firstWidget(localIdDialogTextFieldFinder) as TextFormField;
      expect(localIdDialogTextFieldFinder, findsOneWidget);
      // 診察券番号入力ダイアログTextFieldの初期値が空であることを確認
      expect(localIdDialogTextField.initialValue, isEmpty);
      // expect(localIdDialogTextField.controller!.text, isEmpty);
      // TextFormFieldに文字入力
      await tester.enterText(localIdDialogTextFieldFinder, '9876543210');
      // 保存ボタンタップ
      await tester.tap(find.text('保存'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 診察券カードの診察券番号に値が入力されていることを確認
      expect(localIdTextField.controller!.text, '9876543210');
      // 再度TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号入力ダイアログTextFieldの初期値が設定されていることを確認
      // 診察券カードTextFieldと入力ダイアログTextFieldの二箇所で値が設定されていることを確認
      expect(find.text('9876543210'), findsNWidgets(2));
      // expect(localIdDialogTextField.controller!.text, '9876543210');
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
      ));
    });

    testWidgets('Test updating local id.', (WidgetTester tester) async {
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
        localId: '1234567890',
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
      when(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
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
      final localIdTextFieldFinder =
          find.byKey(const Key('localId-TextField-92506199'));
      final localIdTextField =
          tester.firstWidget(localIdTextFieldFinder) as TextField;
      expect(localIdTextFieldFinder, findsOneWidget);
      expect(localIdTextField.controller!.text, '1234567890');
      // 診察券カードを全て表示させる為ListViewを画面下部にスクロール
      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pump();
      // TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号登録ダイアログ表示確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('診察券番号登録'), findsOneWidget);
      expect(find.text('診察券番号'), findsNWidgets(2));
      expect(find.text('診察券番号を入力してください'), findsNWidgets(2));
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
      // TextField要素確認
      final localIdDialogTextFieldFinder =
          find.byKey(const Key('localId-dialog-TextField-92506199'));
      final localIdDialogTextField =
          tester.firstWidget(localIdDialogTextFieldFinder) as TextFormField;
      expect(localIdDialogTextFieldFinder, findsOneWidget);
      // 診察券番号入力ダイアログTextFieldの初期値が設定されていることを確認
      expect(localIdDialogTextField.initialValue, '1234567890');
      // expect(localIdDialogTextField.controller!.text, '1234567890');
      // TextFormFieldに文字入力
      await tester.enterText(localIdDialogTextFieldFinder, '9876543210');
      // 保存ボタンタップ
      await tester.tap(find.text('保存'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 診察券カードの診察券番号に値が入力されていることを確認
      expect(localIdTextField.controller!.text, '9876543210');
      // 再度TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号入力TextFieldの初期値が設定されていることを確認
      // 診察券カードTextFieldと入力ダイアログTextFieldの二箇所で値が設定されていることを確認
      expect(find.text('9876543210'), findsNWidgets(2));
      // expect(localIdDialogTextField.controller!.text, '9876543210');
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
      ));
    });
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
      when(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
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
      final localIdTextFieldFinder =
          find.byKey(const Key('localId-TextField-92506199'));
      final localIdTextField =
          tester.firstWidget(localIdTextFieldFinder) as TextField;
      expect(localIdTextFieldFinder, findsOneWidget);
      expect(localIdTextField.controller!.text, isEmpty);
      // 診察券カードを全て表示させる為ListViewを画面下部にスクロール
      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pump();
      // TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号登録ダイアログ表示確認
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('診察券番号登録'), findsOneWidget);
      expect(find.text('診察券番号'), findsNWidgets(2));
      expect(find.text('診察券番号を入力してください'), findsNWidgets(2));
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
      // TextField要素確認
      final localIdDialogTextFieldFinder =
          find.byKey(const Key('localId-dialog-TextField-92506199'));
      final localIdDialogTextField =
          tester.firstWidget(localIdDialogTextFieldFinder) as TextFormField;
      expect(localIdDialogTextFieldFinder, findsOneWidget);
      // 診察券番号入力ダイアログTextFieldの初期値が設定されていることを確認
      expect(localIdDialogTextField.initialValue, isEmpty);
      // TextFormFieldに文字入力
      await tester.enterText(localIdDialogTextFieldFinder, '9876543210');
      // 保存ボタンタップ
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();
      // Error widget表示確認
      expect(find.byType(SnackBar), findsOneWidget);
      // エラー文言を確認
      expect(find.text('Exception: Error message.'), findsOneWidget);
      // キャンセルボタンタップ
      await tester.tap(find.text('キャンセル'));
      // 画面遷移後のWidgetがレンダリング完了するまで処理を待機
      await tester.pumpAndSettle();
      // 診察券カードの診察券番号に値が入力されていないことを確認
      expect(localIdTextField.controller!.text, isEmpty);
      // 再度TextFieldをタップしてダイアログ表示
      await tester.tap(localIdTextFieldFinder);
      await tester.pump();
      // 診察券番号入力ダイアログTextFieldの初期値が設定されていないことを確認
      expect(find.text('9876543210'), findsNothing);
      // expect(localIdDialogTextField.controller!.text, isEmpty);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
      verify(_updateLocalIdRepository.updateLocalId(
        institutionId: 92506,
        userId: 199,
        localId: '9876543210',
      ));
    });
  });
}
