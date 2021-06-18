import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/user_management_repository.dart';
import 'package:nomoca_flutter/errors/authentication_error.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import '../main.dart';

final userManagementRepositoryProvider =
    Provider.autoDispose<UserManagementRepository>((ref) =>
        UserManagementRepositoryImpl(userDao: ref.read(userDaoProvider)));

final userManagementViewState =
    FutureProvider.autoDispose<UserNicknameEntity>((ref) async {
  final repository = ref.read(userManagementRepositoryProvider);
  return repository.getUser();
});

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
      // DBからUserEntity取得
      body: useProvider(userManagementViewState).maybeWhen(
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
                  onPressed: () => _transitionToNextScreen(context, user: user),
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
              // 認証エラーはログイン画面へ遷移
              await Navigator.pushNamed(context, RouteNames.signIn);
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
