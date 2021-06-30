import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/presentation/asset_image_path.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';

import 'components/molecules/images_slider.dart';

class InstitutionView extends HookWidget with AssetImagePath {
  final body1 = '''
Today, we’re pleased to announce the release of Flutter 2. 
It’s been a little more than two years since the Flutter 1.0 release, but in that short time, we’ve closed 24,541 issues and merged 17,039 PRs from 765 contributors.
Just since the Flutter 1.22 release in September, we’ve closed 5807 issues and merged 4091 PRs from 298 contributors.
Special thanks go out to our volunteer contributors who generously give their spare time to improve the Flutter project.
The top volunteer contributors for the Flutter 2 release were xu-baolin with 46 PRs, a14n with 32 PRs that focused on bringing Flutter to null safety, and hamdikahloun with 20 PRs that improved a number of the Flutter plugins.
But it’s not just coders that contribute to the Flutter project; a great set of volunteer PR reviewers were also responsible for reviewing 1525 PRs, including hamdikahloun (again!), CareF and YazeedAlKhalaf (who’s only 16!). Flutter is truly a community effort and we couldn’t have gotten to version 2 without the issue raisers, PR contributors, and code reviewers. This release is for all of you.
  ''';

  final body2 = '''
Adapting to screen size & input devices
User interface controls adapt their density, hit areas,
and presentation based on screen size and whether the user is using touch or mouse/keyboard.
Keyboard shortcuts, scroll wheel, and right-click accelerate tasks when available.''';

  @override
  Widget build(BuildContext context) {
    var institutionId = ModalRoute.of(context)!.settings.arguments as int?;
    institutionId = 99999;
    return useProvider(getInstitutionProvider(institutionId)).when(
      data: (entity) {
        return Hero(
          tag: 'card-$institutionId',
          child: Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  // pinned: true, AppBarを固定表示する
                  elevation: 0,
                  stretch: true,
                  flexibleSpace: _flexibleSpaceBar(entity, context),
                  expandedHeight:
                      entity.images != null && entity.images!.isNotEmpty
                          ? 320
                          : 240,
                  backgroundColor: Colors.white,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.pink,
                      onPressed: () async {
                        await _updateFavorite(
                            entity.isFavorite, entity.id, context);
                      },
                    ),
                  ],
                ),
                SliverList(
                  delegate: _sliverChildListDelegate(),
                )
              ],
            ),
          ),
        );
      },
      loading: () => Container(),
      error: (error, _) => Container(),
    );
  }

  Widget _flexibleSpaceBar(InstitutionEntity entity, BuildContext context) {
    return FlexibleSpaceBar(
      stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      // title: Text(
      //   entity.name,
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      //   style: const TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      // ),
      centerTitle: true,
      background: Stack(
        // StackFit.expandで画像を下にスワイプした時に画像が拡大する
        fit: StackFit.expand,
        children: <Widget>[
          entity.images != null && entity.images!.isNotEmpty
              // 施設画像スライダー
              ? ImagesSlider(images: entity.images!)
              // 施設画像が無ければデフォルト画像表示
              : Image(
                  fit: BoxFit.cover,
                  image: AssetImage(getRandomInstitutionImagePath()),
                ),
        ],
      ),
    );
  }

  SliverChildListDelegate _sliverChildListDelegate() {
    return SliverChildListDelegate(
      <Widget>[
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Today, we’re pleased to announce the release of Flutter 2',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                body1,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
              const Text(
                'Adapting to screen size & input devices',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                body2,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<bool> _updateFavorite(
      bool isLike, int institutionId, BuildContext context) async {
    return await context.read(updateFavoriteProvider(institutionId)).maybeWhen(
          data: (_) async {
            // TODO: このデータブロックに処理が入らないので調査
            // お気に入り登録時SnackBar表示
            if (!isLike) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('お気に入り登録しました')));
            }
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
}
