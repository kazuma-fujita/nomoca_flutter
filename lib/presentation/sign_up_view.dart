import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/states/providers/create_user_provider.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: _Form(),
      ),
    );
  }
}

class _Form extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = useState('');
    final mobilePhoneNumber = useState('');

    // ボタン押下時処理
    final asyncValue = ref.watch(createUserProvider)
      ..when(
        data: (isSuccess) async {
          if (isSuccess) {
            // ローディング非表示
            await EasyLoading.dismiss();
            // 認証画面へ遷移
            await Navigator.pushNamed(context, RouteNames.authentication,
                arguments: mobilePhoneNumber.value);
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        const Text(
          'ご入力頂いた電話番号宛に確認コードが記載されたSMSを送信します',
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const Key('nickname'),
                  // initialValue: args.textFormFieldInitialValue(),
                  maxLength: 10,
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
                TextFormField(
                  key: const Key('mobilePhoneNumber'),
                  maxLength: 11,
                  decoration: const InputDecoration(
                    hintText: '携帯電話番号を入力してください',
                    labelText: '携帯電話番号',
                  ),
                  validator: (String? input) {
                    return input == null || input.isEmpty
                        ? '携帯電話番号を入力してください'
                        : null;
                  },
                  onSaved: (String? input) {
                    mobilePhoneNumber.value = input!;
                  },
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        OutlinedButton(
          // 読み込み中はボタンdisabled
          onPressed: () => asyncValue is AsyncLoading
              ? null
              : _submission(
                  mobilePhoneNumber,
                  nickname,
                  ref,
                ),
          child: const Text('アカウント新規登録'),
        ),
        const Spacer(),
      ],
    );
  }

  void _submission(
    ValueNotifier<String> mobilePhoneNumber,
    ValueNotifier<String> nickname,
    WidgetRef ref,
  ) {
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(createUserProvider.notifier).createUser(
            mobilePhoneNumber: mobilePhoneNumber.value,
            nickname: nickname.value,
          );
    }
  }
}
