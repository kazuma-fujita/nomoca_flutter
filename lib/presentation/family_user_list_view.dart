import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/api/delete_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/delete_family_user_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

final _deleteFamilyUserApiProvider = Provider.autoDispose(
  (ref) => DeleteFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final deleteFamilyUserRepositoryProvider =
    Provider.autoDispose<DeleteFamilyUserRepository>(
  (ref) => DeleteFamilyUserRepositoryImpl(
    deleteFamilyUserApi: ref.read(_deleteFamilyUserApiProvider),
  ),
);

final deleteFamilyUserProvider =
    FutureProvider.autoDispose.family<void, int>((ref, familyUserId) async {
  final repository = ref.read(deleteFamilyUserRepositoryProvider);
  return repository.deleteUser(familyUserId: familyUserId);
});

class FamilyUserListView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = useProvider(familyUserListReducer);
    return Scaffold(
      appBar: AppBar(
        title: const Text('家族アカウント管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            disabledColor: Colors.black,
            // List取得成功時以外は+ボタンdisabled
            onPressed: () => asyncValue is AsyncData
                ? _transitionToNextScreen(context)
                : null,
          ),
        ],
      ),
      body: asyncValue.when(
        data: (entities) => entities.isNotEmpty
            ? ListView.builder(
                key: UniqueKey(),
                padding: const EdgeInsets.all(16),
                itemCount: entities.length,
                itemBuilder: (BuildContext context, int index) {
                  return _dismissible(entities[index], context);
                },
              )
            : _emptyListView(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () => context.refresh(familyUserListReducer),
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
            '家族アカウントを登録しましょう',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          Text(
            '+ボタンから家族アカウントを追加できます',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(UserNicknameEntity user, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListTile(
        key: Key(user.id.toString()),
        title: Text(
          user.nickname,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          _transitionToNextScreen(context, user: user);
        },
      ),
    );
  }

  Future<void> _transitionToNextScreen(BuildContext context,
      {UserNicknameEntity? user}) async {
    // upsert-user画面へ遷移。pushNamedの戻り値は遷移先から取得した値。
    final result = await Navigator.pushNamed(context, RouteNames.upsertUser,
            arguments: UpsertUserViewArguments(isFamilyUser: true, user: user))
        as String?;

    if (result != null) {
      // 家族アカウントを(作成/編集)しましたメッセージをSnackBarで表示
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  Widget _dismissible(UserNicknameEntity user, BuildContext context) {
    // ListViewのswipeができるwidget
    return Dismissible(
      // ユニークな値を設定
      key: Key(user.id.toString()),
      confirmDismiss: (direction) async {
        final confirmResult =
            await _showDeleteConfirmDialog(user.nickname, context);
        // Future<bool> で確認結果を返す。False の場合削除されない
        return confirmResult;
      },
      onDismissed: (DismissDirection direction) {
        // listItem削除のcallback処理。以下関数で削除APIを実行
        _deleteFamilyUser(context, user);
      },
      // swipe中ListTileのbackground
      background: Container(
        alignment: Alignment.centerLeft,
        // backgroundが赤/ゴミ箱Icon表示
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: _listItem(user, context),
    );
  }

  Future<bool?> _showDeleteConfirmDialog(
      String title, BuildContext context) async {
    final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('削除'),
            content: Text('$titleを削除しますか？'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('OK'),
              ),
            ],
          );
        });
    return result;
  }

  Future<void> _deleteFamilyUser(
      BuildContext context, UserNicknameEntity user) async {
    await context.read(deleteFamilyUserProvider(user.id)).maybeWhen(
        data: (_) async {
          // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
          context.read(familyUserActionDispatcher).state =
              FamilyUserAction.delete(user);
          // 診察券画面の状態更新。patientCardStateではAPI経由で診察券情報を再取得する
          await context.refresh(patientCardState);
          // 削除メッセージを表示
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${user.nickname}を削除しました')));
        },
        error: (error, _) {
          // SnackBar表示
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
        orElse: () {});
  }
}
