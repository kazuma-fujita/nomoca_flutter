import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/api/create_family_user_api.dart';
import 'package:nomoca_flutter/data/api/update_family_user_api.dart';
import 'package:nomoca_flutter/data/entity/remote/user_nickname_entity.dart';
import 'package:nomoca_flutter/data/repository/create_family_user_repository.dart';
import 'package:nomoca_flutter/data/repository/update_family_user_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/states/actions/family_user_action.dart';
import 'package:nomoca_flutter/states/reducers/family_user_list_reducer.dart';

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

final createFamilyUserProvider = FutureProvider.autoDispose
    .family<UserNicknameEntity, String>((ref, nickname) async {
  final repository = CreateFamilyUserRepositoryImpl(
    createFamilyUserApi: ref.read(createFamilyUserApiProvider),
  );
  return repository.createUser(nickname: nickname);
});

final updateFamilyUserProvider = FutureProvider.autoDispose
    .family<UserNicknameEntity, UserNicknameEntity>((ref, entity) async {
  final repository = UpdateFamilyUserRepositoryImpl(
    updateFamilyUserApi: ref.read(updateFamilyUserApiProvider),
  );
  return repository.updateUser(
      familyUserId: entity.id, nickname: entity.nickname);
});

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
    // user情報があれば家族アカウント作成、無ければ更新
    final asyncValue = watch(args!.user == null
        ? createFamilyUserProvider(_nickname)
        : updateFamilyUserProvider(args.user!.copyWith(nickname: _nickname)));
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              // initialValue: user != null ? user.nickname : '',
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
      asyncValue.when(
        data: (response) async {
          final entity = response as UserNicknameEntity;
          // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
          context.read(familyUserActionDispatcher).state = args!.user == null
              ? FamilyUserAction.create(entity)
              : FamilyUserAction.update(entity);
          // 診察券画面の状態更新。patientCardStateではAPI経由で診察券情報を再取得する
          await context.refresh(patientCardState);
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
