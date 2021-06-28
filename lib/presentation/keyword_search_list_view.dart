import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/keyword_search_properties.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'components/atoms/animated_push_motion.dart';
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
  // ページング閾値
  static const _threshold = 0.8;
  // 初期表示位置を渋谷駅に設定
  final Position _initialPosition = Position(
    latitude: 35.658034,
    longitude: 139.701636,
    timestamp: DateTime.now(),
    altitude: 0,
    accuracy: 0,
    heading: 0,
    floor: null,
    speed: 0,
    speedAccuracy: 0,
  );

  // 現在位置座標を取得
  Future<void> _setCurrentLocation(ValueNotifier<Position> position) async {
    // 位置情報パーミッションが選択されていない場合は位置情報取得許可ダイアログを表示
    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
    );
    const decimalPoint = 3;
    // 過去の座標と最新の座標の小数点第三位で切り捨てた値を判定
    if ((position.value.latitude).toStringAsFixed(decimalPoint) !=
            (currentPosition.latitude).toStringAsFixed(decimalPoint) &&
        (position.value.longitude).toStringAsFixed(decimalPoint) !=
            (currentPosition.longitude).toStringAsFixed(decimalPoint)) {
      print(
          'current lat:${currentPosition.latitude} long: ${currentPosition.longitude}');
      // 現在地座標のstateを更新する
      position.value = currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController(
        text: context.read(keywordSearchQueryState).state);
    final focusNode = useFocusNode();
    final offset = useState(0);
    final position = useState<Position>(_initialPosition);
    // 現在位置情報取得
    _setCurrentLocation(position);
    // 初回表示 or 位置情報取得時一覧取得。緯度経度取得毎にuseEffect内が実行される
    useEffect(() {
      print(
          'useEffect lat:${position.value.latitude} long: ${position.value.longitude}');
      // 全Widgetのbuild後にAPI経由で一覧取得
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        context.read(keywordSearchListActionDispatcher).state =
            KeywordSearchListAction.fetchList(
          query: textController.text,
          offset: 0,
          limit: KeywordSearchProperties.limit,
          latitude: position.value.latitude,
          longitude: position.value.longitude,
        );
      });
    }, [position.value]);

    // ページング時一覧取得。offset変更毎にuseEffect内が実行される
    useEffect(() {
      // offsetが0以上の場合ページング一覧取得実行
      if (offset.value > 0) {
        print(
            'useEffect offset: ${offset.value} limit: ${KeywordSearchProperties.limit}');
        // 全Widgetのbuild後にAPI経由で一覧取得
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          context.read(keywordSearchListActionDispatcher).state =
              KeywordSearchListAction.fetchList(
            query: textController.text,
            offset: offset.value,
            limit: KeywordSearchProperties.limit,
            latitude: position.value.latitude,
            longitude: position.value.longitude,
          );
        });
      }
    }, [offset.value]);

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
            // 検索処理開始
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
              latitude: position.value.latitude,
              longitude: position.value.longitude,
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
            child: _scrollListView(offset, position),
          ),
        ),
      ],
    );
  }

  Widget _scrollListView(
      ValueNotifier<int> offset, ValueNotifier<Position> position) {
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
            }
            return false;
          },
          child: items.isNotEmpty
              ? ListView.builder(
                  key: ObjectKey(items[0]),
                  itemCount: items.length,
                  itemBuilder: (BuildContext _context, int index) {
                    return _buildRow(items[index], context);
                  },
                )
              : _emptyListView(),
        );
      },
    );
  }

  Widget _buildRow(KeywordSearchEntity entity, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      // Widgetを押し込むpushアニメーションを付与
      child: AnimatedPushMotion(
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
                            context
                                .read(updateFavoriteProvider(entity.id))
                                .maybeWhen(
                                  error: (error, _) {
                                    // SnackBar表示
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())));
                                  },
                                  orElse: () {},
                                );
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
