import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/providers/create_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';
import 'package:nomoca_flutter/states/providers/update_family_user_provider.dart';
import 'package:nomoca_flutter/states/providers/update_user_provider.dart';
import 'package:nomoca_flutter/states/providers/user_management_provider.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

class UpsertUserView extends StatelessWidget {
  const UpsertUserView({this.args});

  final UpsertUserViewArguments? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args!.screenTitle()),
      ),
      body: _Form(args: args),
    );
  }
}

class _Form extends HookConsumerWidget {
  _Form({this.args});

  final _formKey = GlobalKey<FormState>();
  final UpsertUserViewArguments? args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一覧画面からuser情報を取得
    final nickname = useState('');
    // ボタン押下時処理
    final asyncValue = ref.watch(
      args!.user == null
          ? createFamilyUserProvider
          : args!.isFamilyUser
              ? updateFamilyUserProvider
              : updateUserProvider,
    )..when(
        data: (entity) async {
          if (entity != null) {
            // ローディング非表示
            await EasyLoading.dismiss();
            // 全てのbuildが終わってから他画面の状態変更処理
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              if (args!.isFamilyUser) {
                // 家族一覧画面の状態更新。
                // dispatcherのstateを更新するとfamilyUserListReducerが再実行される
                ref.read(familyUserActionDispatcher).state = args!.user == null
                    ? FamilyUserAction.create(entity)
                    : FamilyUserAction.update(entity);
              } else if (args!.user != null) {
                // プロフィール画面のニックネーム更新。DBからニックネーム再取得
                ref.refresh(userManagementProvider);
              }
              // 診察券画面の状態更新。patientCardProviderではAPI経由で診察券情報を再取得する
              ref.refresh(patientCardProvider);
              // 遷移元画面へ戻る
              // Navigator.pop(context, args!.navigationPopMessage());
              Navigator.pop(context);
              // 作成・編集しましたメッセージをSnackBarで表示
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(args!.navigationPopMessage())));
            });
          }
        },
        loading: () async {
          // ローディング表示
          await EasyLoading.show();
        },
        error: (error, _) {
          // ローディング非表示
          EasyLoading.dismiss();
          // SnackBar表示
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
          });
        },
      );

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              initialValue: args!.textFormFieldInitialValue(),
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: 'ニックネームを入力してください',
                labelText: 'ニックネーム',
              ),
              validator: (String? input) {
                return input == null || input.isEmpty
                    ? 'ニックネームを入力してください'
                    : null;
              },
              onSaved: (String? input) {
                nickname.value = input!;
              },
            ),
            ElevatedButton(
              onPressed: () => asyncValue is AsyncLoading
                  ? null
                  : _submission(context, nickname: nickname, ref: ref),
              child: const Text('保存する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(
    BuildContext context, {
    required ValueNotifier<String> nickname,
    required WidgetRef ref,
  }) {
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = args!.user;
      // プロフィール or 家族アカウント作成・更新
      if (user == null) {
        ref
            .read(createFamilyUserProvider.notifier)
            .createUser(nickname: nickname.value);
      } else {
        if (args!.isFamilyUser) {
          ref
              .read(updateFamilyUserProvider.notifier)
              .updateUser(familyUserId: user.id, nickname: nickname.value);
        } else {
          ref
              .read(updateUserProvider.notifier)
              .updateUser(userId: user.id, nickname: nickname.value);
        }
      }
    }
  }
}
