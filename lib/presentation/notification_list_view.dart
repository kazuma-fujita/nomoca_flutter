import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/states/actions/notification_list_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/notification_list_reducer.dart';

import 'asset_image_path.dart';

class NotificationListView extends HookWidget with AssetImagePath {
  @override
  Widget build(BuildContext context) {
    final asyncValue = useProvider(notificationListReducer);
    return Scaffold(
      appBar: AppBar(
        title: const Text('お知らせ'),
      ),
      body: asyncValue.when(
        data: (entities) => entities.isNotEmpty
            ? Scrollbar(
                child: ListView.builder(
                  key: UniqueKey(),
                  padding: const EdgeInsets.all(16),
                  itemCount: entities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listItem(entities[index], context);
                  },
                ),
              )
            : _emptyListView(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () => context.refresh(notificationListReducer),
        ),
      ),
    );
  }

  Widget _emptyListView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'お知らせがありません',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(NotificationEntity notification, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListTile(
        key: Key(notification.id.toString()),
        title: Text(
          notification.detail.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight:
                notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          notification.detail.deliveryDate,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight:
                notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        // 施設画像があれば画像取得。無ければデフォルト施設画像をランダムで表示
        leading: notification.detail.imageUrl != null
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  notification.detail.imageUrl!,
                ),
              )
            : CircleAvatar(
                backgroundImage: AssetImage(
                  getRandomInstitutionImagePath(),
                ),
              ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          _transitionToNextScreen(context, notification);
        },
      ),
    );
  }

  Future<void> _transitionToNextScreen(
      BuildContext context, NotificationEntity notification) async {
    // 詳細画面へ遷移。pushNamedの戻り値は遷移先から取得した値。
    final notificationId = await Navigator.pushNamed(
            context, RouteNames.notificationDetail, arguments: notification)
        as int?;

    if (notificationId != null) {
      // 既読未読を更新
      context.read(notificationListActionDispatcher).state =
          NotificationListAction.isRead(notificationId);
    }
  }
}
