import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';

@immutable
class UserManagementViewData {
  const UserManagementViewData({
    required this.caption,
    required this.description,
    required this.transitionRoute,
  });
  final String caption;
  final String description;
  final String transitionRoute;
}

final userManagementViewDataProvider =
    Provider.autoDispose<List<UserManagementViewData>>((ref) => const [
          UserManagementViewData(
            caption: '家族アカウント管理',
            description: '家族アカウントの追加/編集/削除を行います',
            transitionRoute: '',
          ),
          UserManagementViewData(
            caption: '診察券登録',
            description: '診察券QRコードを読み込んで病院を追加します',
            transitionRoute: '',
          ),
          UserManagementViewData(
            caption: '設定',
            description: '通知設定やログアウトを行います',
            transitionRoute: '',
          ),
        ]);

class UserManagementView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewDataList = context.read(userManagementViewDataProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 64),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'ようこそ○○○さん',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 32,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('プロフィール編集'),
            ),
          ),
          ListView.builder(
            key: UniqueKey(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: viewDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return _listItem(viewDataList[index], context);
            },
          ),
        ],
      ),
    );
  }

  Widget _listItem(UserManagementViewData viewData, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListTile(
        title: Text(
          viewData.caption,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          viewData.description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // _transitionToNextScreen(context, user: user);
        },
      ),
    );
  }

  Future<void> _transitionToNextScreen(BuildContext context,
      {UserNicknameEntity? user}) async {
    // upsert-user画面へ遷移。pushNamedの戻り値は遷移先から取得した値。
    final result = await Navigator.pushNamed(context, RouteNames.upsertUser,
        arguments: user) as String?;

    if (result != null) {
      // 家族アカウントを(作成/更新)しましたメッセージをSnackBarで表示
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }
}
