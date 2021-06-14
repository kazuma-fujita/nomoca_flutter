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

final createFamilyUserRepositoryProvider = Provider<CreateFamilyUserRepository>(
  (ref) => CreateFamilyUserRepositoryImpl(
    createFamilyUserApi: ref.read(createFamilyUserApiProvider),
  ),
);

final updateFamilyUserRepositoryProvider = Provider<UpdateFamilyUserRepository>(
  (ref) => UpdateFamilyUserRepositoryImpl(
    updateFamilyUserApi: ref.read(updateFamilyUserApiProvider),
  ),
);

final createFamilyUserProvider =
    FutureProvider.autoDispose.family<UserNicknameEntity, String>(
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
    final user =
        ModalRoute.of(context)!.settings.arguments as UserNicknameEntity?;
    // user情報があれば家族アカウント作成、無ければ更新
    final asyncValue = watch(user == null
        ? createFamilyUserProvider(_nickname)
        : updateFamilyUserProvider(user));
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
              onPressed: () => _submission(context, asyncValue: asyncValue),
              child: const Text('保存する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context, {required AsyncValue asyncValue}) {
    final user =
        ModalRoute.of(context)!.settings.arguments as UserNicknameEntity?;
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      asyncValue.when(
        data: (response) async {
          print('Data here $response');
          final entity = response as UserNicknameEntity;
          // 家族一覧画面の状態更新。dispatcherのstateを更新するとfamilyUserListReducerが再実行される
          context.read(familyUserActionDispatcher).state = user == null
              ? FamilyUserAction.create(entity)
              : FamilyUserAction.update(entity);
          // 診察券画面の状態更新。patientCardStateではAPI経由で診察券情報を再取得する
          await context.refresh(patientCardState);
          // ローディング非表示
          await EasyLoading.dismiss();
          // 一覧画面へ遷移
          Navigator.pop(
              context, '$_nicknameを${user == null ? '作成' : '更新'}しました');
        },
        loading: () async {
          // ローディング表示
          await EasyLoading.show();
        },
        error: (error, _) {
          EasyLoading.dismiss();
          // SnackBar表示
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    }
  }
}
