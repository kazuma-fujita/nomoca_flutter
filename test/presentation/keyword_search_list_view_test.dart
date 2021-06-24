import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/data/repository/keyword_search_repository.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/image_slider.dart';
import 'package:nomoca_flutter/presentation/keyword_search_list_view.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';

import 'keyword_search_list_view_test.mocks.dart';

@GenerateMocks([
  KeywordSearchRepository,
])
void main() {
  final _listRepository = MockKeywordSearchRepository();

  // Widget testはHTTP 通信が 400 - Bad Request になる仕様
  // Image.network() で画像の取得が失敗する為、400 errorになる仕組みを無効化
  setUpAll(() => HttpOverrides.global = null);

  tearDown(() {
    reset(_listRepository);
  });

  ProviderScope _setUpProviderScope() {
    return ProviderScope(
      overrides: [
        // 一覧画面の初期状態を設定
        keywordSearchRepositoryProvider.overrideWithValue(_listRepository),
      ],
      child: MaterialApp(
        home: KeywordSearchView(),
      ),
    );
  }

  Future<void> _verifyTheStatusBeforeAfterLoading(WidgetTester tester) async {
    // 画面要素チェック
    expect(find.text('病院を探す'), findsOneWidget);
    // ローディング表示を確認
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Widgetがレンダリング完了するまで処理を待機
    await tester.pump();
    // エラー、ローディング非表示を確認
    expect(find.byType(ErrorSnackBar), findsNothing);
    // expect(find.byType(CircularProgressIndicator), findsNothing);
  }

  group('Testing keyword search view.', () {
    testWidgets('Testing empty data view.', (WidgetTester tester) async {
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => []);
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 空データ文言を確認
      expect(find.text('病院が見つかりません'), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      ));
    });

    testWidgets('Testing display widget of list.', (WidgetTester tester) async {
      const contentsBaseUrl = 'https://contents.nomoca.com';
      final results = [
        const KeywordSearchEntity(
          id: 92506,
          name: '渋谷リーフクリニック',
          address: '渋谷区道玄坂2-23-14',
          isFavorite: false,
          buildingName: null,
          images: null,
        ),
        const KeywordSearchEntity(
          id: 120,
          name: 'タカデンタルクリニック',
          address: '渋谷区恵比寿1-19-18',
          isFavorite: false,
          buildingName: '石渡ビル3F',
          images: [
            '$contentsBaseUrl/institutions/120/image1/2ac467ca7fec709b12ae312efd83dea9.jpg',
            '$contentsBaseUrl/institutions/120/image2/ed8e976d057a014575cee7730d120717.jpg',
            '$contentsBaseUrl/institutions/120/image4/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          ],
        ),
        const KeywordSearchEntity(
          id: 90093,
          name: '小笠原歯科',
          address: '渋谷区道玄坂2-25-5',
          isFavorite: true,
          buildingName: '島田ビル4F',
          images: [
            '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
            '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
            '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
            '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
            '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
          ],
        )
      ];
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      )).thenAnswer((_) async => results);
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      await _verifyTheStatusBeforeAfterLoading(tester);
      // 画面要素を確認
      expect(find.text('渋谷リーフクリニック'), findsOneWidget);
      expect(find.text('渋谷区道玄坂2-23-14'), findsOneWidget);
      expect(find.text('タカデンタルクリニック'), findsOneWidget);
      expect(find.text('渋谷区恵比寿1-19-18 石渡ビル3F'), findsOneWidget);
      expect(find.text('小笠原歯科'), findsOneWidget);
      expect(find.text('渋谷区道玄坂2-25-5 島田ビル4F'), findsOneWidget);
      expect(find.byType(ImageSlider), findsNWidgets(2));
      expect(find.byType(LikeButton), findsNWidgets(2));
      // LikeButtonチェック KeyはinstitutionId
      final likeButton1Finder = find.byKey(const Key('like-120'));
      final likeButton1 = tester.firstWidget(likeButton1Finder) as LikeButton;
      expect(likeButton1Finder, findsOneWidget);
      expect(likeButton1.isLiked, false);
      final likeButton2Finder = find.byKey(const Key('like-90093'));
      final likeButton2 = tester.firstWidget(likeButton2Finder) as LikeButton;
      expect(likeButton2Finder, findsOneWidget);
      expect(likeButton2.isLiked, true);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      ));
    });
  });

  group('Testing error of keyword search view.', () {
    testWidgets('Testing display of error.', (WidgetTester tester) async {
      // 一覧APIレスポンスデータを設定
      when(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      )).thenThrow(Exception('Error message.'));
      // 一覧画面Widgetをレンダリング
      await tester.pumpWidget(_setUpProviderScope());
      expect(find.text('病院を探す'), findsOneWidget);
      // Widgetがレンダリングし終わるまで待機
      await tester.pump();
      // 空データ文言を確認
      expect(find.text('病院が見つかりません'), findsOneWidget);
      // Error widget表示確認
      expect(find.byType(ErrorSnackBar), findsOneWidget);
      // Mock呼び出しを検証
      verify(_listRepository.fetchList(
        query: anyNamed('query'),
        offset: anyNamed('offset'),
        limit: anyNamed('limit'),
      ));
    });
  });
}
