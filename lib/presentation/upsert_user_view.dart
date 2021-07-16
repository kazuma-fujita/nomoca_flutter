import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/providers/upsert_user_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

class UpsertUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UpsertUserViewArguments?;
    return Scaffold(
      appBar: AppBar(
        // title: Text('家族アカウント${user == null ? '作成' : '編集'}'),
        title: Text(args!.screenTitle()),
      ),
      body: _Form(),
    );
  }
}

// ignore: must_be_immutable
class _Form extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  String _nickname = '';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 一覧画面からuser情報を取得
    final args =
        ModalRoute.of(context)!.settings.arguments as UpsertUserViewArguments?;
    final user = args!.user;
    final asyncValue = watch(user == null
        ? createFamilyUserProvider(_nickname)
        : args.isFamilyUser
            ? updateFamilyUserProvider(user.copyWith(nickname: _nickname))
            : updateUserProvider(user.copyWith(nickname: _nickname)));
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              initialValue: args.textFormFieldInitialValue(),
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
              onPressed: () => _submission(context, asyncValue: asyncValue),
              child: const Text('保存する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context, {required AsyncValue asyncValue}) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UpsertUserViewArguments?;
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // プロフィール or 家族アカウント作成・更新
      asyncValue.when(
        data: (response) async {
          final entity = response as UserNicknameEntity;
          if (args!.isFamilyUser) {
            // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
            context.read(familyUserActionDispatcher).state = args.user == null
                ? FamilyUserAction.create(entity)
                : FamilyUserAction.update(entity);
          } else if (args.user != null) {
            // プロフィール画面のニックネーム更新。DBからニックネーム再取得
            await context.refresh(userManagementProvider);
          }
          // 診察券画面の状態更新。patientCardProviderではAPI経由で診察券情報を再取得する
          await context.refresh(patientCardProvider);
          // ローディング非表示
          await EasyLoading.dismiss();
          // 一覧画面へ遷移。引数に遷移後の表示メッセージを設定
          Navigator.pop(context, args.navigationPopMessage());
        },
        loading: () async {
          // ローディング表示
          await EasyLoading.show();
        },
        error: (error, _) {
          // ローディング非表示
          EasyLoading.dismiss();
          // SnackBar表示
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    }
  }
}
