import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';
import 'package:nomoca_flutter/mocks/mock_providers.dart';
import 'package:nomoca_flutter/presentation/bottom_navigation_bar_view.dart';
import 'package:nomoca_flutter/presentation/top_view.dart';
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
      home: BottomNavigationBarView(),
      builder: EasyLoading.init(),
    );
  }
}
