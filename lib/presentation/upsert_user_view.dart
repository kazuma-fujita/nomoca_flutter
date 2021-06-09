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
        ModalRoute.of(context)!.settings.arguments as UserNicknameEntity?;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              initialValue: user != null ? user.nickname : '',
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
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as UserNicknameEntity?;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final asyncValue = user == null
          ? context.read(createFamilyUserProvider(_nickname))
          : context.read(updateFamilyUserProvider(user));
      // ignore: cascade_invocations
      asyncValue.when(
        data: (_) async {
          print('Data here');
          await EasyLoading.dismiss();
          Navigator.pop(
            context,
            '$_nicknameを${user == null ? '作成' : '更新'}しました',
          );
        },
        loading: () async {
          print('Loading here');
          await EasyLoading.show();
        },
        error: (error, _) {
          print('Error here');
          EasyLoading.dismiss();
          _errorView(context, error.toString());
        },
      );
    }
  }

  void _errorView(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
