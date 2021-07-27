import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/providers/delete_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

class QrReadConfirmView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(familyUserListReducer);
    return Scaffold(
      appBar: AppBar(
        title: const Text('診察券登録'),
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
                  return _dismissible(entities[index], context, ref);
                },
              )
            : _emptyListView(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () => ref.refresh(familyUserListReducer),
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

  Widget _dismissible(
    UserNicknameEntity user,
    BuildContext context,
    WidgetRef ref,
  ) {
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
        _deleteFamilyUser(context, user, ref);
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
    BuildContext context,
    UserNicknameEntity user,
    WidgetRef ref,
  ) async {
    await ref.read(deleteFamilyUserProvider(user.id)).maybeWhen(
        data: (_) async {
          // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
          ref.read(familyUserActionDispatcher).state =
              FamilyUserAction.delete(user);
          // 診察券画面の状態更新。patientCardProviderではAPI経由で診察券情報を再取得する
          ref.refresh(patientCardProvider);
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
