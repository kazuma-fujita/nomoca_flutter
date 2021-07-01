import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/data/repository/get_institution_repository.dart';
import 'package:nomoca_flutter/data/repository/update_favorite_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/images_slider.dart';
import 'package:nomoca_flutter/presentation/institution_view.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';

import 'institution_view_test.mocks.dart';

@GenerateMocks([
  GetInstitutionRepository,
  UpdateFavoriteRepository,
])
void main() {
  final _listRepository = MockGetInstitutionRepository();
  final _updateFavoriteRepository = MockUpdateFavoriteRepository();

  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  tearDown(() {
    reset(_listRepository);
    reset(_updateFavoriteRepository);
  });

  ProviderScope _setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // 一覧画面の初期状態を設定
        getInstitutionRepositoryProvider.overrideWithValue(_listRepository),
        // お気に入りボタンタップ時のAPIレスポンスを設定
        updateFavoriteRepositoryProvider
            .overrideWithValue(_updateFavoriteRepository),
      ],
      child: MaterialApp(
        home: InstitutionView(),
      ),
    );
  }

  Future<void> _verifyTheStatusBeforeAfterLoading(WidgetTester tester) async {
    // ローディング表示を確認
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Widgetがレンダリング完了するまで処理を待機
    await tester.pump();
    // 画面要素チェック
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    // エラー、ローディング非表示を確認
    expect(find.byType(ErrorSnackBar), findsNothing);
    // expect(find.byType(CircularProgressIndicator), findsNothing);
  }

  group('Testing institution view.', () {
    testWidgets('Testing display of full element.',
        (WidgetTester tester) async {
      const contentsBaseUrl = 'https://contents.nomoca.com';
      const result = InstitutionEntity(
        id: 92506,
        name: 'テストデンタルクリニック',
        type: 'dentistry',
        category: '歯科 / 小児歯科 / 矯正歯科',
        feature: '駅徒歩5分以内 / 保険診療 / 女性スタッフ / クレジットカード / 二ヶ国語',
        businessHour:
            '[月・火・水・金]10:00～14:00/15:00～19:00\r\n[土]10:00～14:00/15:00～17:00',
        businessHoliday: '木曜、日曜、祝日',
        address: '杉並区堀ノ内2-6-21',
        buildingName: 'パークハイム杉並C棟1F',
        access: '東京メトロ丸ノ内線 方南町駅から530m(徒歩 7分)\r\n東京メトロ丸ノ内線 東高円寺駅から1km(徒歩18分)',
        title1: '院長挨拶',
        body1: '歯科医療を通して地域医療に少しでも貢献していければ幸いです。\r\nどうぞよろしくお願いいたします。',
        title2: '診療方針',
        body2: 'テストクリニックでは、患者様一人ひとりにあった治療を行っております。\r\n患者様の立場になり、最良の治療をご提供します。',
        title3: '所属学会・研究会',
        body3: '日本接着歯学会\r\n\r\n日本口腔衛生学会\r\n\r\n日本矯正歯科学会',
        phoneNumber: '0120-811-009',
        webSiteUrl: 'https://genova.co.jp/',
        reserveUrl:
            'https://reserve.nomoca.com/reserves/new1?reserve_token=DnN8QxBGeFBC150NZqEHKq9gQqY',
        isPhoneButtonHidden: false,
        medicalDocumentUrl:
            'https://medicaldoc.jp/recommend/nishiogikubo-st-haisha/',
        longitude: 139.7241604,
        latitude: 35.6363211,
        isFavorite: true,
        images: [
          '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
          '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
          '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
          '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
        ],
      );
      // 一覧APIレスポンスデータを設定
      when(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      )).thenAnswer((_) async => result);
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      await tester.pump();
      // 画面要素を確認
      expect(find.text('テストデンタルクリニック'), findsOneWidget);
      expect(find.text('歯科 / 小児歯科 / 矯正歯科'), findsOneWidget);
      expect(find.text('こだわり・特徴'), findsOneWidget);
      expect(find.text('駅徒歩5分以内 / 保険診療 / 女性スタッフ / クレジットカード / 二ヶ国語'),
          findsOneWidget);
      expect(find.text('診療時間'), findsOneWidget);
      expect(
          find.text(
              '[月・火・水・金]10:00～14:00/15:00～19:00\r\n[土]10:00～14:00/15:00～17:00'),
          findsOneWidget);
      expect(find.text('休診日'), findsOneWidget);
      expect(find.text('木曜、日曜、祝日'), findsOneWidget);
      expect(find.text('アクセス'), findsOneWidget);
      expect(
          find.text(
              '東京メトロ丸ノ内線 方南町駅から530m(徒歩 7分)\r\n東京メトロ丸ノ内線 東高円寺駅から1km(徒歩18分)'),
          findsOneWidget);
      expect(find.text('院長挨拶'), findsOneWidget);
      expect(find.text('歯科医療を通して地域医療に少しでも貢献していければ幸いです。\r\nどうぞよろしくお願いいたします。'),
          findsOneWidget);
      expect(find.text('診療方針'), findsOneWidget);
      expect(
          find.text(
              'テストクリニックでは、患者様一人ひとりにあった治療を行っております。\r\n患者様の立場になり、最良の治療をご提供します。'),
          findsOneWidget);
      expect(find.text('所属学会・研究会'), findsOneWidget);
      expect(
          find.text('日本接着歯学会\r\n\r\n日本口腔衛生学会\r\n\r\n日本矯正歯科学会'), findsOneWidget);
      expect(find.byType(ImagesSlider), findsWidgets);
      // likeButtonが点灯していることを確認
      final likeButtonFinder = find.byType(IconButton);
      final likeButton = tester.firstWidget(likeButtonFinder) as IconButton;
      expect(likeButton.color, Colors.pink);
      // Mock呼び出しを検証
      verify(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      ));
    });

    testWidgets('Testing display of min element.', (WidgetTester tester) async {
      const result = InstitutionEntity(
        id: 92506,
        name: 'テストデンタルクリニック',
        type: 'dentistry',
        category: '歯科 / 小児歯科 / 矯正歯科',
        feature: null,
        businessHour: null,
        businessHoliday: null,
        address: '杉並区堀ノ内2-6-21',
        buildingName: null,
        access: null,
        title1: '院長挨拶',
        body1: null,
        title2: '診療方針',
        body2: null,
        title3: '所属学会・研究会',
        body3: null,
        phoneNumber: '0120-811-009',
        webSiteUrl: null,
        reserveUrl: null,
        isPhoneButtonHidden: true,
        medicalDocumentUrl: null,
        longitude: 139.7241604,
        latitude: 35.6363211,
        isFavorite: false,
        images: [],
      );
      // 一覧APIレスポンスデータを設定
      when(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      )).thenAnswer((_) async => result);
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      await tester.pump();
      // 画面要素を確認
      expect(find.text('テストデンタルクリニック'), findsOneWidget);
      expect(find.text('歯科 / 小児歯科 / 矯正歯科'), findsOneWidget);
      expect(find.text('こだわり・特徴'), findsNothing);
      expect(find.text('診療時間'), findsNothing);
      expect(find.text('休診日'), findsNothing);
      expect(find.text('アクセス'), findsNothing);
      expect(find.text('院長挨拶'), findsNothing);
      expect(find.text('診療方針'), findsNothing);
      expect(find.text('所属学会・研究会'), findsNothing);
      expect(find.byType(ImagesSlider), findsNothing);
      expect(find.byType(Image), findsOneWidget);
      // likeButtonが消灯していることを確認
      final likeButtonFinder = find.byType(IconButton);
      final likeButton = tester.firstWidget(likeButtonFinder) as IconButton;
      // expect(likeButton.color, Colors.pink);
      // Mock呼び出しを検証
      verify(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      ));
    });
    // testWidgets('Testing update of favorite button.',
    //     (WidgetTester tester) async {
    //   const contentsBaseUrl = 'https://contents.nomoca.com';
    //   final results = [
    //     const KeywordSearchEntity(
    //       id: 120,
    //       name: 'タカデンタルクリニック',
    //       address: '渋谷区恵比寿1-19-18',
    //       isFavorite: false,
    //       buildingName: '石渡ビル3F',
    //       images: [
    //         '$contentsBaseUrl/institutions/120/image1/2ac467ca7fec709b12ae312efd83dea9.jpg',
    //         '$contentsBaseUrl/institutions/120/image2/ed8e976d057a014575cee7730d120717.jpg',
    //         '$contentsBaseUrl/institutions/120/image4/e907cf5540089bcdb1787a2d979e6a7b.jpg',
    //       ],
    //     ),
    //   ];
    //   // 一覧APIレスポンスデータを設定
    //   when(_listRepository.getInstitution(
    //     institutionId: anyNamed('institutionId'),
    //   )).thenAnswer((_) async => results);
    //   // お気に入りボタン更新APIレスポンスデータ設定
    //   when(_updateFavoriteRepository.updateFavorite(
    //           institutionId: anyNamed('institutionId')))
    //       .thenAnswer((_) => Future.value());
    //   // 一覧画面Widgetをレンダリング
    //   await tester.pumpWidget(_setUpProviderScope());
    //   await _verifyTheStatusBeforeAfterLoading(tester);
    //   await tester.pump();
    //   // 画面要素を確認
    //   expect(find.text('タカデンタルクリニック'), findsOneWidget);
    //   expect(find.text('渋谷区恵比寿1-19-18 石渡ビル3F'), findsOneWidget);
    //   expect(find.byType(ImagesSlider), findsOneWidget);
    //   expect(find.byType(LikeButton), findsOneWidget);
    //   // LikeButtonチェック KeyはinstitutionId
    //   final likeButtonFinder = find.byKey(const Key('like-120'));
    //   final likeButton = tester.firstWidget(likeButtonFinder) as LikeButton;
    //   expect(likeButtonFinder, findsOneWidget);
    //   expect(likeButton.isLiked, false);
    //   // LikeButtonタップ
    //   await tester.tap(likeButtonFinder);
    //   await tester.pump();
    //   // TODO: お気に入りボタンが点灯したことが検証できないので調査
    //   // expect(likeButton.isLiked, true);
    //   // Mock呼び出しを検証
    //   verify(_listRepository.getInstitution(
    //     institutionId: anyNamed('institutionId'),
    //   ));
    //   verify(_updateFavoriteRepository.updateFavorite(
    //       institutionId: anyNamed('institutionId')));
    // });
  });

  group('Testing error of institution view.', () {
    testWidgets('Testing display of error.', (WidgetTester tester) async {
      // 一覧APIレスポンスデータを設定
      when(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      )).thenThrow(Exception('Error message.'));
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      // Widgetがレンダリングし終わるまで待機
      await tester.pumpAndSettle();
      // 空データ文言を確認
      // expect(find.text('病院が見つかりません'), findsOneWidget);
      // Error widget表示確認
      expect(find.byType(ErrorSnackBar), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.getInstitution(
        institutionId: anyNamed('institutionId'),
      ));
    });
  });
}
