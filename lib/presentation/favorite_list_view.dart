import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/presentation/components/atoms/animated_push_motion.dart';
import 'package:nomoca_flutter/presentation/components/atoms/parallax_card.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/images_slider.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/arguments/favorite_patient_card_arguments.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'asset_image_path.dart';

class FavoriteListView extends HookConsumerWidget with AssetImagePath {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('かかりつけ'),
      ),
      body: ref.watch(favoriteListReducer).when(
            data: (entities) => entities.isNotEmpty
                ? Scrollbar(
                    child: ListView.builder(
                      key: ObjectKey(entities[0]),
                      padding: const EdgeInsets.all(16),
                      itemCount: entities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildRow(context, entities[index], index, ref);
                      },
                    ),
                  )
                : _emptyListView(),
            loading: _shimmerView,
            error: (error, _) => ErrorSnackBar(
              errorMessage: error.toString(),
              callback: () => ref.refresh(favoriteListReducer),
            ),
          ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    FavoriteEntity entity,
    int verticalIndex,
    WidgetRef ref,
  ) {
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
                              isLike,
                              entity.institutionId,
                              context,
                              ref,
                            );
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
        itemCount: entity.userIds.length,
        onPageChanged: (int index) {},
        itemBuilder: (context, horizontalIndex) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Card(
            // key: Key(
            //     '$verticalIndex$horizontalIndex${entity.userIds[horizontalIndex]}'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
              child: _HorizontalItemView(
                entity,
                verticalIndex,
                horizontalIndex,
                key: Key(
                    '$verticalIndex$horizontalIndex${entity.userIds[horizontalIndex]}'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _updateFavorite(
    bool isLike,
    int institutionId,
    BuildContext context,
    WidgetRef ref,
  ) async {
    return await ref.read(updateFavoriteProvider(institutionId)).maybeWhen(
          data: (_) async {
            // お気に入り登録時SnackBar表示
            if (!isLike) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('お気に入り登録しました')));
            }
            // キーワード検索画面のお気に入りボタン更新
            ref.read(keywordSearchListActionDispatcher).state =
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

  Widget _shimmerView() {
    return SingleChildScrollView(
      child: Shimmer(
        duration: const Duration(milliseconds: 1500),
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              Container(
                height: 210,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 64, 16),
                child: Container(
                  height: 24,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Container(
                  height: 280,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HorizontalItemView extends HookConsumerWidget {
  const _HorizontalItemView(
      this.entity, this.verticalIndex, this.horizontalIndex,
      {required Key key})
      : super(key: key);

  final FavoriteEntity entity;
  final int verticalIndex;
  final int horizontalIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = FavoritePatientCardArguments(
      userId: entity.userIds[horizontalIndex],
      institutionId: entity.institutionId,
    );
    return ref
        .watch(
          getFavoritePatientCardProvider(args
              // {
              //   'userId': entity.userIds[horizontalIndex],
              //   'institutionId': entity.institutionId
              // },
              ),
        )
        .when(
          data: (patientCard) {
            print(
                'V: $verticalIndex H: $horizontalIndex name: ${patientCard.nickname} localId: ${patientCard.localId} reserveDate: ${patientCard.reserveDate} receptionDate: ${patientCard.lastReceptionDate}');
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    '診察券',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: null),
                  decoration: const InputDecoration(
                    hintText: '診察券番号を入力してください',
                    labelText: '診察券番号',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: ''),
                  decoration: const InputDecoration(
                    hintText: '次回予約日時メモを入力してください',
                    labelText: '次回予約日時メモ',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '前回受付',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
                const Text(
                  '----/--/--  --:--',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
          loading: () {
            print('V: $verticalIndex H: $horizontalIndex now loading');
            return _patientCardShimmerView();
          },
          error: (error, _) => ErrorSnackBar(
            errorMessage: error.toString(),
            callback: () => ref.refresh(favoriteListReducer),
          ),
        );
  }

  Widget _patientCardShimmerView() {
    return Shimmer(
      duration: const Duration(milliseconds: 1500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Container(
                height: 20,
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 88),
            child: Container(
              height: 16,
              color: Colors.grey[300],
            ),
          ),
          Container(
            height: 32,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 72),
            child: Container(
              height: 16,
              color: Colors.grey[300],
            ),
          ),
          Container(
            height: 32,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 96),
            child: Container(
              height: 16,
              color: Colors.grey[300],
            ),
          ),
          Container(
            height: 24,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
