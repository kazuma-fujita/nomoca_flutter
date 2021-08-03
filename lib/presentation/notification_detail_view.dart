import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/presentation/asset_image_path.dart';
import 'package:nomoca_flutter/states/providers/update_read_post_provider.dart';

class NotificationDetailView extends HookConsumerWidget with AssetImagePath {
  const NotificationDetailView(this.notification);

  final NotificationEntity? notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final notification =
    //     ModalRoute.of(context)!.settings.arguments as NotificationEntity?;
    return WillPopScope(
      // 戻るボタンevent
      onWillPop: () async {
        // 既読API実行
        ref.read(updateReadPostProvider(notification!.id));
        Navigator.pop(context, notification!.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(notification!.detail.contributor),
        ),
        body: _body(notification!, context),
      ),
    );
  }

  Widget _body(NotificationEntity notification, BuildContext context) {
    return Column(
      children: [
        _tile(notification),
        Expanded(
          child: Scrollbar(
            isAlwaysShown: false,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              // color: Colors.amberAccent,
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  notification.detail.body,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tile(NotificationEntity notification) {
    return ListTile(
      key: Key(notification.id.toString()),
      title: Text(
        notification.detail.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        notification.detail.deliveryDate,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10,
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
    );
  }
}
