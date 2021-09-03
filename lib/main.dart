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
import 'package:nomoca_flutter/fcm_settings.dart';
import 'package:nomoca_flutter/mocks/mock_providers.dart';
import 'package:nomoca_flutter/presentation/settings_view.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/presentation/root_view.dart';
import 'package:nomoca_flutter/routes/route_generator.dart';
import 'package:nomoca_flutter/themes/easy_loading_theme.dart';
import 'package:nomoca_flutter/themes/theme_data.dart';

import 'constants/db_table_names.dart';

Future<void> main() async {
  initEasyLoading();
  // Initializes Hive.
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  await Hive.openBox<User>(DBTableNames.users);
  // DateFormat日本語化の為のメソッドを追加
  // await initializeDateFormatting('ja');
  // FCMプッシュ通知設定
  await fcmSettings();
  runApp(
    ProviderScope(
      overrides: MockProviders.overrides(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nomoca application',
      // Default theme
      theme: lightThemeData,
      // Dark mode theme
      darkTheme: lightThemeData,
      // darkTheme: darkThemeData,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: RootView(),
      home: FavoriteListView(),
      builder: EasyLoading.init(),
      // locale設定
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // localeに英語と日本語を登録
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      // アプリのlocaleを日本語に変更
      locale: const Locale('ja', 'JP'),
    );
  }
}
