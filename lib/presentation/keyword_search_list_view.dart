import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/keyword_search_properties.dart';
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
      body: _KeywordSearchView(),
    );
  }
}

class _KeywordSearchView extends HookWidget {
  static const _threshold = 0.8;

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController(
        text: context.read(keywordSearchQueryState).state);
    final focusNode = useFocusNode();
    final offset = useState(0);
    // focusイベントは常に複数走る為、useEffectで同時に走るイベントは一度のみ実行するように制御
    useEffect(() {
      // TextFieldのfocus in/outをハンドリング
      focusNode.addListener(() {
        debugPrint("Focus Change : ${focusNode.hasFocus}");
        // TextFieldのfocusが外れたら検索処理開始
        if (!focusNode.hasFocus) {
          // 検索文字列が前回と同じ場合、API検索処理を走らせない
          final pastQuery = context.read(keywordSearchQueryState).state;
          if (textController.text != pastQuery) {
            print('Search keyword[${textController.text}]');
            // offset初期化
            offset.value = 0;
            // 検索文字列更新
            context.read(keywordSearchQueryState).state = textController.text;
            // TextFieldのfocusが外れたら検索文字列で一覧取得
            context.read(keywordSearchListActionDispatcher).state =
                KeywordSearchListAction.fetchList(
              query: textController.text,
              offset: 0,
              limit: KeywordSearchProperties.limit,
            );
          }
        }
      });
    }, [focusNode]);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 32, 8),
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: textController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              hintText: '病院名',
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            // ListViewタップ時TextFieldのフォーカスを外しKeyboardを非表示にする
            onTap: () => FocusScope.of(context).unfocus(),
            child: _scrollListView(offset),
          ),
        ),
      ],
    );
  }

  Widget _scrollListView(ValueNotifier<int> offset) {
    // キーワード検索画面はページネーションを行う為、直接listStateを参照
    final context = useContext();
    final items = useProvider(keywordSearchListState).state;
    return useProvider(keywordSearchListReducer).maybeWhen(
      error: (error, _) {
        return ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () => context.refresh(keywordSearchListReducer),
          backScreenWidget: _emptyListView(),
        );
      },
      // ページネーションローディング時の再ビルド防止の為、エラー以外はListViewを表示
      orElse: () {
        // 画面のスクロール量を取得する為、ListViewをNotificationListenerでWrapする
        return NotificationListener<ScrollNotification>(
          // 画面スクロールをトリガーに onNotification callback がcallされる
          onNotification: (ScrollNotification scrollInfo) {
            // ListViewスクロール時TextFieldのフォーカスを外しKeyboardを非表示にする
            FocusScope.of(context).unfocus();
            // ListViewの高さに対する画面の表示割合
            final scrollProportion =
                scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent;
            // 次回取得予定のオフセット値
            final nextOffset = offset.value + KeywordSearchProperties.limit;
            // 画面表示割合がListViewの高さに対する閾値を超える
            // かつ、ListViewの長さ = 次回取得予定オフセット値ならばAPI経由でページングリストを取得
            if (scrollProportion > _threshold && items.length == nextOffset) {
              // オフセット値の更新
              offset.value = nextOffset;
              print(
                  'offset: ${offset.value} limit: ${KeywordSearchProperties.limit}');
              // API経由でページングリストの取得
              context.read(keywordSearchListActionDispatcher).state =
                  KeywordSearchListAction.fetchList(
                query: '',
                offset: offset.value,
                limit: KeywordSearchProperties.limit,
              );
            }
            return false;
          },
          child: items.isNotEmpty
              ? ListView.builder(
                  key: ObjectKey(items[0]),
                  itemCount: items.length,
                  itemBuilder: (BuildContext _context, int index) {
                    return _buildRow(items[index]);
                  },
                )
              : _emptyListView(),
        );
      },
    );
  }

  Widget _buildRow(KeywordSearchEntity entity) {
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
                        key: Key('like-${entity.id.toString()}'),
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
                  // ignore: lines_longer_than_80_chars
                  '${entity.address}${entity.buildingName != null ? ' ${entity.buildingName}' : ''}',
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
