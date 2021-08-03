import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/qr_read_select_user_type_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';

@immutable
class _UserManagementViewData {
  const _UserManagementViewData({
    required this.caption,
    required this.description,
    required this.transitionRoute,
    required this.transitionRouteName,
    required this.isFullScreenDialog,
  });
  final String caption;
  final String description;
  final Widget transitionRoute;
  final String transitionRouteName;
  final bool isFullScreenDialog;
}

final _userManagementViewDataProvider =
    Provider.autoDispose<List<_UserManagementViewData>>((ref) => [
          _UserManagementViewData(
            caption: '家族アカウント管理',
            description: '家族アカウントの追加/編集/削除を行います',
            transitionRoute: FamilyUserListView(),
            transitionRouteName: RouteNames.familyUserList,
            isFullScreenDialog: false,
          ),
          _UserManagementViewData(
            caption: '診察券登録',
            description: '診察券QRコードを読み込んで病院を追加します',
            transitionRoute: QrReadSelectUserTypeView(),
            transitionRouteName: RouteNames.qrReadSelectUserType,
            isFullScreenDialog: true,
          ),
          _UserManagementViewData(
            caption: '設定',
            description: '通知設定やログアウトを行います',
            transitionRoute: FamilyUserListView(),
            transitionRouteName: RouteNames.familyUserList,
            isFullScreenDialog: false,
          ),
        ]);

class UserManagementView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 診察券登録画面戻りのハンドリング
    final result = ModalRoute.of(context)!.settings.arguments as String?;
    if (result != null) {
      // 戻り値が存在する場合メッセージをSnackBarで表示
      // 全Widgetのbuild後にsnackBarを表示
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      });
    }

    final viewDataList = ref.read(_userManagementViewDataProvider);
    return Scaffold(
      // DBからUserEntity取得
      body: ref.watch(userManagementProvider).maybeWhen(
            data: (user) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'ようこそ${user.nickname}さん',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          _transitionToUpsertUserView(context, user: user),
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
              );
            },
            error: (error, _) {
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                if (error is AuthenticationError) {
                  // 認証エラーはtop画面へ遷移
                  await Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.top, (_) => false);
                }
                // その他エラーをSnackBarで表示
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
              });
            },
            orElse: () {},
          ),
    );
  }

  Widget _listItem(_UserManagementViewData viewData, BuildContext context) {
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
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => viewData.transitionRoute,
          //       fullscreenDialog: viewData.isFullScreenDialog,
          //     ));
          Navigator.pushNamed(context, viewData.transitionRouteName);
        },
      ),
    );
  }

  Future<void> _transitionToUpsertUserView(BuildContext context,
      {required UserNicknameEntity user}) async {
    // upsert-user画面へ遷移。pushNamedの戻り値は遷移先から取得した値。
    final result = await Navigator.pushNamed(context, RouteNames.upsertUser,
        arguments: UpsertUserViewArguments(user: user)) as String?;

    if (result != null) {
      // プロフィールを更新しましたメッセージをSnackBarで表示
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }
}
