import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';
import 'package:nomoca_flutter/data/repository/get_favorite_patient_card_repository.dart';
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/images_slider.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'favorite_list_view_test.mocks.dart';

@GenerateMocks([
  FetchFavoriteListRepository,
  GetFavoritePatientCardRepository,
  UpdateFavoriteRepository,
])
void main() {
  final _listRepository = MockFetchFavoriteListRepository();
  final _patientCardRepository = MockGetFavoritePatientCardRepository();
  final _updateFavoriteRepository = MockUpdateFavoriteRepository();
  const contentsBaseUrl = 'https://contents.nomoca.com';

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
        // 一覧画面の初期状態を設定
        fetchFavoriteListRepositoryProvider.overrideWithValue(_listRepository),
        // 診察券カード要素の初期状態を設定
        getFavoritePatientCardRepositoryProvider
            .overrideWithValue(_patientCardRepository),
        // お気に入りボタンタップ時のAPIレスポンスを設定
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

  group('Testing favorite view.', () {
    testWidgets('Testing display of min element.', (WidgetTester tester) async {
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
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      // 画面要素、ローディング表示を確認
      await _verifyTheStatusBeforeAfterLoading(tester);
      // レンダリング後の画面要素を確認
      expect(find.byType(Image), findsNWidgets(1));
      expect(find.text('渋谷リーフクリニック'), findsOneWidget);
      // likeButtonが点灯していることを確認
      final likeButtonFinder = find.byKey(const Key('like-92506'));
      final likeButton = tester.firstWidget(likeButtonFinder) as LikeButton;
      expect(likeButtonFinder, findsOneWidget);
      expect(likeButton.isLiked, isTrue);
      // 診察券カード要素確認
      expect(find.text('太郎の診察券'), findsOneWidget);
      expect(find.text('診察券番号'), findsOneWidget);
      expect(find.text('次回予約日時メモ'), findsOneWidget);
      expect(find.text('前回受付'), findsOneWidget);
      expect(find.text('---- / -- / --  -- : --'), findsOneWidget);
      // TextField要素確認
      final localIdTextFieldFinder =
          find.byKey(const Key('localId-TextField-92506199'));
      final localIdTextField =
          tester.firstWidget(localIdTextFieldFinder) as TextField;
      expect(localIdTextFieldFinder, findsOneWidget);
      expect(localIdTextField.controller!.text, isEmpty);
      final nextReserveDateTextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-92506199'));
      final nextReserveDateTextField =
          tester.firstWidget(nextReserveDateTextFieldFinder) as TextField;
      expect(nextReserveDateTextFieldFinder, findsOneWidget);
      expect(nextReserveDateTextField.controller!.text, isEmpty);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      ));
    });

    testWidgets('Testing display of full element.',
        (WidgetTester tester) async {
      final entities = [
        const FavoriteEntity(
          institutionId: 92506,
          type: 'clinic',
          name: '渋谷リーフクリニック',
          images: null,
          userIds: [199, 200, 201],
        ),
        const FavoriteEntity(
          institutionId: 90093,
          type: 'dentistry',
          name: '小笠原歯科',
          images: [
            '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
            '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
            '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
            '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
            '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
          ],
          userIds: [199, 200, 201],
        ),
      ];
      final patientCards = [
        const FavoritePatientCardEntity(
          institutionId: 92506,
          userId: 199,
          nickname: '太郎',
          localId: null,
          reserveDate: null,
          lastReceptionDate: null,
          isPatient: false,
        ),
        const FavoritePatientCardEntity(
          institutionId: 92506,
          userId: 200,
          nickname: '二郎',
          localId: '1234567890',
          reserveDate: '2021/08/24(木) 11:30',
          lastReceptionDate: '2021/08/14(土) 20:45',
          isPatient: false,
        ),
        const FavoritePatientCardEntity(
          institutionId: 90093,
          userId: 199,
          nickname: '太郎',
          localId: '1100',
          reserveDate: '2021/07/06(火) 16:00',
          lastReceptionDate: '2021/06/25(金) 09:00',
          isPatient: false,
        ),
        const FavoritePatientCardEntity(
          institutionId: 90093,
          userId: 200,
          nickname: '二郎',
          localId: null,
          reserveDate: null,
          lastReceptionDate: null,
          isPatient: false,
        ),
        const FavoritePatientCardEntity(
          institutionId: 92506,
          userId: 201,
          nickname: '三郎',
          localId: null,
          reserveDate: null,
          lastReceptionDate: null,
          isPatient: false,
        ),
        const FavoritePatientCardEntity(
          institutionId: 90093,
          userId: 201,
          nickname: '三郎',
          localId: null,
          reserveDate: null,
          lastReceptionDate: null,
          isPatient: false,
        ),
      ];

      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenAnswer((_) async => entities);
      // 診察券カードAPIレスポンスデータを設定
      when(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      )).thenAnswer((_) async => patientCards.removeAt(0));
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      // 画面要素、ローディング表示を確認
      await _verifyTheStatusBeforeAfterLoading(tester);
      /*
      1件目の医院要素確認
       */
      // レンダリング後の画面要素を確認
      expect(find.byType(Image), findsNWidgets(1));
      expect(find.text('渋谷リーフクリニック'), findsOneWidget);
      // likeButtonが点灯していることを確認
      final likeButton1Finder = find.byKey(const Key('like-92506'));
      final likeButton1 = tester.firstWidget(likeButton1Finder) as LikeButton;
      expect(likeButton1Finder, findsOneWidget);
      expect(likeButton1.isLiked, isTrue);
      // 診察券カード要素確認
      expect(find.text('太郎の診察券'), findsOneWidget);
      expect(find.text('二郎の診察券'), findsOneWidget);
      expect(find.text('診察券番号'), findsNWidgets(2));
      expect(find.text('次回予約日時メモ'), findsNWidgets(2));
      expect(find.text('前回受付'), findsNWidgets(2));
      expect(find.text('---- / -- / --  -- : --'), findsNWidgets(1));
      expect(find.text('2021/08/14(土) 20:45'), findsNWidgets(1));
      // TextField要素確認
      final localId1TextFieldFinder =
          find.byKey(const Key('localId-TextField-92506199'));
      final localId1TextField =
          tester.firstWidget(localId1TextFieldFinder) as TextField;
      expect(localId1TextFieldFinder, findsOneWidget);
      expect(localId1TextField.controller!.text, isEmpty);
      final nextReserveDate1TextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-92506199'));
      final nextReserveDate1TextField =
          tester.firstWidget(nextReserveDate1TextFieldFinder) as TextField;
      expect(nextReserveDate1TextFieldFinder, findsOneWidget);
      expect(nextReserveDate1TextField.controller!.text, isEmpty);
      final localId2TextFieldFinder =
          find.byKey(const Key('localId-TextField-92506200'));
      final localId2TextField =
          tester.firstWidget(localId2TextFieldFinder) as TextField;
      expect(localId2TextFieldFinder, findsOneWidget);
      expect(localId2TextField.controller!.text, '1234567890');
      final nextReserveDate2TextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-92506200'));
      final nextReserveDate2TextField =
          tester.firstWidget(nextReserveDate2TextFieldFinder) as TextField;
      expect(nextReserveDate2TextFieldFinder, findsOneWidget);
      expect(nextReserveDate2TextField.controller!.text, '2021/08/24(木) 11:30');
      /*
      1件目医院の診察券カードをスワイプして3件目の診察券を表示
       */
      // await tester.drag(find.byType(PageView), const Offset(400, 0));
      // Widgetがレンダリング完了するまで処理を待機
      // await tester.pump();
      /*
      2件目の医院要素確認
       */
      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pump();
      // レンダリング後の画面要素を確認
      expect(find.byType(ImagesSlider), findsOneWidget);
      expect(find.text('小笠原歯科'), findsOneWidget);
      // likeButtonが点灯していることを確認
      final likeButton2Finder = find.byKey(const Key('like-90093'));
      final likeButton2 = tester.firstWidget(likeButton2Finder) as LikeButton;
      expect(likeButton2Finder, findsOneWidget);
      expect(likeButton2.isLiked, isTrue);
      // 診察券カード要素確認
      expect(find.text('太郎の診察券'), findsOneWidget);
      expect(find.text('二郎の診察券'), findsOneWidget);
      expect(find.text('診察券番号'), findsNWidgets(2));
      expect(find.text('次回予約日時メモ'), findsNWidgets(2));
      expect(find.text('前回受付'), findsNWidgets(2));
      expect(find.text('2021/06/25(金) 09:00'), findsNWidgets(1));
      expect(find.text('---- / -- / --  -- : --'), findsNWidgets(1));
      // TextField要素確認
      final localId3TextFieldFinder =
          find.byKey(const Key('localId-TextField-90093199'));
      final localId3TextField =
          tester.firstWidget(localId3TextFieldFinder) as TextField;
      expect(localId3TextFieldFinder, findsOneWidget);
      expect(localId3TextField.controller!.text, '1100');
      final nextReserveDate3TextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-90093199'));
      final nextReserveDate3TextField =
          tester.firstWidget(nextReserveDate3TextFieldFinder) as TextField;
      expect(nextReserveDate3TextFieldFinder, findsOneWidget);
      expect(nextReserveDate3TextField.controller!.text, '2021/07/06(火) 16:00');
      final localId4TextFieldFinder =
          find.byKey(const Key('localId-TextField-90093200'));
      final localId4TextField =
          tester.firstWidget(localId4TextFieldFinder) as TextField;
      expect(localId4TextFieldFinder, findsOneWidget);
      expect(localId4TextField.controller!.text, isEmpty);
      final nextReserveDate4TextFieldFinder =
          find.byKey(const Key('nextReserveDate-TextField-90093200'));
      final nextReserveDate4TextField =
          tester.firstWidget(nextReserveDate4TextFieldFinder) as TextField;
      expect(nextReserveDate4TextFieldFinder, findsOneWidget);
      expect(nextReserveDate4TextField.controller!.text, isEmpty);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
      verify(_patientCardRepository.get(
        userId: anyNamed('userId'),
        institutionId: anyNamed('institutionId'),
      )).called(4);
    });

    testWidgets('Testing update of favorite button.',
        (WidgetTester tester) async {
      // // Mockデータを用意
      // _givenMinElementData();
      // // お気に入りボタン更新APIレスポンスデータ設定
      // when(_updateFavoriteRepository.updateFavorite(
      //         institutionId: anyNamed('institutionId')))
      //     .thenAnswer((_) => Future.value());
      // // 一覧画面Widgetをレンダリング
      // await tester.pumpWidget(_setUpProviderScope());
      // await _verifyTheStatusBeforeAfterLoading(tester);
      // await tester.pump();
      // // likeButtonが消灯していることを確認
      // final likeButtonFinder = find.byKey(const Key('like-92506'));
      // final likeButton = tester.firstWidget(likeButtonFinder) as LikeButton;
      // expect(likeButtonFinder, findsOneWidget);
      // expect(likeButton.isLiked, isFalse);
      // // likeButtonタップ
      // await tester.tap(likeButtonFinder);
      // // アニメーションが完全に終了するまで待機
      // await tester.pump();
      // // likeButtonが点灯することを確認
      // // expect(likeButton.isLiked, isTrue);
      // // 再びlikeButtonタップ
      // await tester.tap(likeButtonFinder);
      // await tester.pump();
      // // likeButtonが消灯することを確認
      // // expect(likeButton.isLiked, isFalse);
      // // Mock呼び出しを検証
      // verify(_listRepository.getInstitution(
      //   institutionId: anyNamed('institutionId'),
      // ));
      // // verify(_updateFavoriteRepository.updateFavorite(
      // //   institutionId: anyNamed('institutionId'),
      // // )).called(2);
      // // 2回ボタンをタップしているが一度しか呼ばれていないので調査
      // verify(_updateFavoriteRepository.updateFavorite(
      //   institutionId: anyNamed('institutionId'),
      // )).called(1);
    });
  });

  group('Testing error of favorite view.', () {
    testWidgets('Testing display of error.', (WidgetTester tester) async {
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList()).thenThrow(Exception('Error message.'));
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      // Widgetがレンダリングし終わるまで待機
      await tester.pumpAndSettle();
      // Error widget表示確認
      expect(find.byType(ErrorSnackBar), findsOneWidget);
      // エラー文言を確認
      expect(find.text('Exception: Error message.'), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList());
    });
  });
}
