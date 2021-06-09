import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/main.dart';

final createFamilyUserApiProvider = Provider(
  (ref) => CreateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final updateFamilyUserApiProvider = Provider(
  (ref) => UpdateFamilyUserApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final createFamilyUserRepositoryProvider = Provider(
  (ref) => CreateFamilyUserRepositoryImpl(
    createFamilyUserApi: ref.read(createFamilyUserApiProvider),
  ),
);

final updateFamilyUserRepositoryProvider = Provider(
  (ref) => UpdateFamilyUserRepositoryImpl(
    updateFamilyUserApi: ref.read(updateFamilyUserApiProvider),
  ),
);

final createFamilyUserProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, nickname) async => ref
      .read(createFamilyUserRepositoryProvider)
      .createUser(nickname: nickname),
);

final updateFamilyUserProvider =
    FutureProvider.autoDispose.family<void, UserNicknameEntity>(
  (ref, entity) async => ref
      .read(updateFamilyUserRepositoryProvider)
      .updateUser(familyUserId: entity.id, nickname: entity.nickname),
);

class UpsertUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家族アカウント'),
      ),
      body: _TodoForm(),
    );
  }
}

// ignore: must_be_immutable
class _TodoForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _nickname = '';

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as UserNicknameEntity;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              // initialValue: todo != null ? todo.title : '',
              maxLength: 20,
              // maxLength以上入力不可
              // maxLengthEnforced: true,
              decoration: const InputDecoration(
                hintText: 'ニックネームを入力してください',
                labelText: 'ニックネーム',
              ),
              validator: (String? title) {
                return title == null || title.isEmpty
                    ? 'ニックネームを入力してください'
                    : null;
              },
              onSaved: (String? title) {
                _nickname = title!;
              },
            ),
            ElevatedButton(
              onPressed: () => _submission(context),
              child: const Text('保存する'),
              // child: Text('Todoを${todo == null ? '作成' : '更新'}する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context) {
    // final todo = ModalRoute.of(context).settings.arguments as TodoEntity;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // viewModelのtodoListを作成
      context.read(createFamilyUserProvider(_nickname)).when(
        data: (_) async {
          print('data here');
          // if (todo != null) {
          await EasyLoading.dismiss();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navigator.pop(context, '${todo.title}を${isNew ? '作成' : '更新'}しました');
          //});
          // }
        },
        loading: () async {
          print('loading here');
          await EasyLoading.show();
        },
        error: (error, _) {
          print('Error here');
          EasyLoading.dismiss();
          _errorView(context, error.toString());
        },
      );
      // if (todo != null) {
      //   // viewModelのtodoListを更新
      //   context.read(upsertTodoViewModelProvider).updateTodo(todo.id, _title);
      // } else {
      //   // viewModelのtodoListを作成
      //   context.read(upsertTodoViewModelProvider).createTodo(_title);
      // }
      // 前の画面に戻る
      // Navigator.pop(context, '$_titleを${todo == null ? '作成' : '更新'}しました');
    }
  }

  void _errorView(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
