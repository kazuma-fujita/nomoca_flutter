import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/data/api/fetch_family_user_list_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_family_user_list_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';

final fetchFamilyUserListApiProvider = Provider(
  (ref) => FetchFamilyUserListApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final fetchFamilyUserListRepositoryProvider = Provider(
  (ref) => FetchFamilyUserListRepositoryImpl(
    fetchFamilyUserListApi: ref.read(fetchFamilyUserListApiProvider),
  ),
);

final familyUserListProvider =
    FutureProvider.autoDispose<List<UserNicknameEntity>>(
  (ref) async => ref.read(fetchFamilyUserListRepositoryProvider).fetchList(),
);

class FamilyUserListView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家族アカウント管理'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return useProvider(familyUserListProvider).when(
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
        callback: () => context.refresh(familyUserListProvider),
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

  Widget _dismissible(UserNicknameEntity entity, BuildContext context) {
    // ListViewのswipeができるwidget
    return Dismissible(
      // ユニークな値を設定
      key: Key(entity.id.toString()),
      confirmDismiss: (direction) async {
        final confirmResult =
            await _showDeleteConfirmDialog(entity.nickname, context);
        // Future<bool> で確認結果を返す。False の場合削除されない
        return confirmResult;
      },
      onDismissed: (DismissDirection direction) {
        // TODO:viewModelのtodoList要素を削除
        // context.read(todoListViewModelProvider).deleteTodo(entity.id);
        // 削除メッセージを表示
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${entity.nickname}を削除しました')));
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
      child: _listItem(entity, context),
    );
  }

  Widget _listItem(UserNicknameEntity entity, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListTile(
        key: Key(entity.id.toString()),
        title: Text(
          entity.nickname,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        onTap: () {
          // TODO: ニックネーム更新画面へ遷移
          // _transitionToNextScreen(context, todo: entity);
        },
      ),
    );
  }

  // TODO: 遷移処理
  // Future<void> _transitionToNextScreen(BuildContext context,
  //     {TodoEntity todo}) async {
  //   final result = await Navigator.pushNamed(context, Const.routeNameUpsertTodo,
  //       arguments: todo);
  //
  //   if (result != null) {
  //     // ToastMessageを表示
  //     await Fluttertoast.showToast(
  //       msg: result.toString(),
  //       backgroundColor: Colors.grey,
  //     );
  //   }
  // }

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
