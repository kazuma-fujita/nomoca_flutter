import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showRequestPermissionDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('カメラを許可してください'),
        content: const Text('QRコードを読み取る為にカメラを利用します'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: const Text('設定'),
          ),
        ],
      );
    },
  );
}
