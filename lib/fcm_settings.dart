import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/mocks/mock_providers.dart';
import 'package:nomoca_flutter/presentation/settings_view.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/presentation/root_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/themes/easy_loading_theme.dart';
import 'package:nomoca_flutter/themes/theme_data.dart';

import 'constants/db_table_names.dart';

Future<void> _iosSettings() async {
  // iOS 固有のフォアグラウンドのプッシュ通知受信時アクションを設定
  // アプリがフォアグラウンド時にプッシュ通知を受信した時に、画面上部に通知メッセージを表示、バッチ数を更新、通知音を鳴らす設定
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> _androidSettings() async {
  // ローカル通知を表示する FlutterLocalNotificationsPlugin オブジェクト
  // Android の notification channel とフォアグラウンドプッシュ通知受信に表示するローカル通知で利用
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // Android Notification Channel 設定
  // この設定内容は Android設定アプリの 'アプリと通知' 画面に表示される
  const channel = AndroidNotificationChannel(
    'NOTIFICATION_CHANNEL_ID', // id 命名はv4アプリから引き継ぎ。本来はclinic_news_channel等が良い
    '病院からのお知らせ', // title
    '病院からのお知らせを配信します。', // description
    importance: Importance.high,
  );
  // Android 固有の Notification Channel を設定
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // フォアグラウンドプッシュ通知を subscribe する listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;
    // Android ではアプリがフォアグラウンド状態で画面上部にプッシュ通知メッセージを
    // 表示することができない為、ローカル通知で擬似的に通知メッセージを表示
    if (notification != null && android != null) {
      // フォアグラウンドでプッシュ通知を受信時、端末がAndroidの場合、ローカル通知を表示
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // ignore: flutter_style_todos
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }
  });
}

// バックグラウンド状態からアプリを起動されたことを subscribe する listener
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  // Firebaseを初期化
  await Firebase.initializeApp();
}

Future<void> fcmSettings() async {
  /// This block is fetching FCM Token and checking permission.
  WidgetsFlutterBinding.ensureInitialized();
  // firebase初期化
  await Firebase.initializeApp();
  print('Called Firebase.initializeApp()');
  // バックグラウンド状態からアプリを起動されたことを subscribe する listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // バックグラウンド状態でプッシュ通知をタップしてアプリを起動されたことを subscribe する listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });
  // Android固有の設定
  await _androidSettings();
  // iOS固有の設定
  await _iosSettings();
  // FCMのインスタンス生成
  final firebaseMessaging = FirebaseMessaging.instance;
  // ターミネイト状態(アプリを落としている状態)でプッシュ通知メッセージからアプリを起動
  await firebaseMessaging.getInitialMessage().then((message) {
    if (message != null) {
      print('Called from terminate status.');
    }
  });
  // FCMToken生成を subscribe する listener。アプリインストール時に必ずcallされる
  await firebaseMessaging.getToken().then((fcmToken) {
    print('Called getToken and FCM Token: $fcmToken');
  });
  // FCMTokenの再生成を subscribe する listener
  firebaseMessaging.onTokenRefresh.listen((fcmToken) {
    // TODO: Token生成タイミングを検証。このタイミングでtokenUpdateAPIを実行
    print('Called onTokenRefresh and FCM Token: $fcmToken');
  });
  // プッシュ通知許可ダイアログ表示
  final settings = await firebaseMessaging.requestPermission();
  // プッシュ通知認証状態をチェック
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
