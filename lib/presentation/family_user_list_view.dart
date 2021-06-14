import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

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
        // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
        context.read(familyUserActionDispatcher).state =
            FamilyUserAction.delete(user);
        // 診察券画面の状態更新。patientCardStateではAPI経由で診察券情報を再取得する
        context.refresh(patientCardState);
        // 削除メッセージを表示
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${user.nickname}を削除しました')));
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
    final result = await Navigator.pushNamed(context, RouteNames.upsertUser,
        arguments: user) as String?;

    if (result != null) {
      // SnackBarを表示
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
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
}
