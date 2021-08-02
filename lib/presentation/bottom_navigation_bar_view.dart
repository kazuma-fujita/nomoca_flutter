import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/presentation/favorite_list_view.dart';
import 'package:nomoca_flutter/presentation/keyword_search_list_view.dart';
import 'package:nomoca_flutter/presentation/notification_list_view.dart';
import 'package:nomoca_flutter/presentation/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';

final _tabTypeProvider =
    AutoDisposeStateProvider<_TabType>((ref) => _TabType.patientCard);

enum _TabType {
  patientCard,
  keywordSearch,
  favoriteList,
  notificationList,
  userManagement,
}

class BottomNavigationBarView extends HookConsumerWidget {
  final _views = [
    PatientCardView(),
    KeywordSearchView(),
    FavoriteListView(),
    NotificationListView(),
    UserManagementView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(_tabTypeProvider);
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: '診察券',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '病院検索',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'かかりつけ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.doorbell_outlined),
              label: 'お知らせ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'プロフィール',
            ),
          ],
          onTap: (int selectIndex) {
            tabType.state = _TabType.values[selectIndex];
          },
          currentIndex: tabType.state.index,
        ),
        body: _views[tabType.state.index],
        // body: ProviderScope(
        //   child: _views[_selectIndex],
        // ),
      ),
    );
  }
}
