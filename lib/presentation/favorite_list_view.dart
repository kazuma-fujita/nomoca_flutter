import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/presentation/components/atoms/animated_push_motion.dart';
import 'package:nomoca_flutter/presentation/components/atoms/parallax_card.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/images_slider.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';

import 'asset_image_path.dart';

class FavoriteListView extends HookWidget with AssetImagePath {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('かかりつけ'),
      ),
      body: useProvider(favoriteListListReducer).when(
        data: (entities) => entities.isNotEmpty
            ? Scrollbar(
                child: ListView.builder(
                  key: UniqueKey(),
                  padding: const EdgeInsets.all(16),
                  itemCount: entities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildRow(context, entities[index], index);
                  },
                ),
              )
            : _emptyListView(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () => context.refresh(familyUserListReducer),
        ),
      ),
    );
  }

  Widget _buildRow(
      BuildContext context, FavoriteEntity entity, int verticalIndex) {
    return AnimatedPushMotion(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 施設画像
          GestureDetector(
            onTap: () async {
              // 詳細画面へ遷移
              await Navigator.pushNamed(context, RouteNames.institution,
                  arguments: entity.institutionId);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Stack(
                    children: <Widget>[
                      entity.images != null && entity.images!.isNotEmpty
                          // 画像スライダー
                          ? ImagesSlider(
                              images: entity.images!, isParallax: true)
                          // デフォルト施設画像表示
                          : ParallaxCard(
                              builder: (backgroundImageKey) {
                                return SizedBox(
                                  key: backgroundImageKey,
                                  // 画像表示領域の高さ
                                  height: 240,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        getRandomInstitutionImagePath()),
                                  ),
                                );
                              },
                            ),
                      // お気に入りボタン位置
                      Positioned(
                        top: 24,
                        right: 24,
                        child: LikeButton(
                          key: Key('like-${entity.institutionId}'),
                          isLiked: true,
                          onTap: (bool isLike) async {
                            // update API実行
                            return _updateFavorite(
                                isLike, entity.institutionId, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 施設名
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    entity.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildHorizontalItem(context, entity, verticalIndex),
        ],
      ),
    );
  }

  Widget _buildHorizontalItem(
      BuildContext context, FavoriteEntity entity, int verticalIndex) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemBuilder: (context, horizontalIndex) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('診察券'),
                  TextField(
                    controller: TextEditingController(text: null),
                    decoration: const InputDecoration(
                      hintText: '診察券番号を入力してください',
                      labelText: '診察券番号',
                    ),
                    // style: const TextStyle(fontSize: 14),
                  ),
                  TextField(
                    controller: TextEditingController(text: ''),
                    decoration: const InputDecoration(
                      hintText: '次回予約日時メモを入力してください',
                      labelText: '次回予約日時メモ',
                    ),
                    // style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '前回受付',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '----/--/--  --:--',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _updateFavorite(
      bool isLike, int institutionId, BuildContext context) async {
    return await context.read(updateFavoriteProvider(institutionId)).maybeWhen(
          data: (_) async {
            // お気に入り登録時SnackBar表示
            if (!isLike) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('お気に入り登録しました')));
            }
            // キーワード検索画面のお気に入りボタン更新
            context.read(keywordSearchListActionDispatcher).state =
                KeywordSearchListAction.toggleFavorite(institutionId);
            // お気に入りボタン反転処理
            return !isLike;
          },
          error: (error, _) {
            // SnackBar表示
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
            // error時お気に入りボタンは変更しない
            return isLike;
          },
          // ローディング中はお気に入りボタン反転処理
          orElse: () => !isLike,
        );
  }

  Widget _emptyListView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'かかりつけ登録をしましょう！',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          Text(
            'かかりつけの病院を登録するには病院を探して\nお気に入りボタンをタップします',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
