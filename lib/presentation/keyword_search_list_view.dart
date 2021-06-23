import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'components/molecules/error_snack_bar.dart';
import 'components/molecules/image_slider.dart';

class KeywordSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('病院を探す'),
      ),
      body: _ScrollListView(),
    );
  }
}

class _ScrollListView extends HookWidget {
  static const _threshold = 0.8;
  static const _limit = 5;
  @override
  Widget build(BuildContext context) {
    final offset = useState(0);
    return useProvider(keywordSearchListReducer).when(
      data: (items) => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final scrollProportion =
              scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent;
          if (scrollProportion > _threshold) {
            offset.value += _limit;
            print('offset: ${offset.value} limit: $_limit');
            context.read(keywordSearchListActionDispatcher).state =
                KeywordSearchListAction.fetchList(
                    query: '', offset: offset.value, limit: _limit);
          }
          return false;
        },
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext _context, int index) {
                  return _buildRow(context, items[index], index);
                },
              )
            : _emptyListView(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorSnackBar(
        errorMessage: error.toString(),
        callback: () => context.refresh(keywordSearchListReducer),
      ),
    );
  }

  Widget _buildRow(
      BuildContext context, KeywordSearchEntity entity, int verticalIndex) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          entity.images != null
              ? Stack(
                  children: <Widget>[
                    // 画像スライダー
                    ImageSlider(images: entity.images!),
                    // お気に入りボタン位置
                    Positioned(
                      top: 24,
                      right: 24,
                      child: LikeButton(
                        key: Key(verticalIndex.toString()),
                        isLiked: entity.isFavorite,
                        onTap: (bool isLiked) async {
                          // update API実行
                          // await context
                          //     .read(favoriteListViewModelProvider)
                          //     .toggleIsFavorite(
                          //     id: favorite.id, isFavorite: favorite.isFavorite);
                          return !isLiked;
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entity.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${entity.address} ${entity.buildingName}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyListView() {
    return const Center(
      child: Text(
        '病院が見つかりません',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    );
  }
}
