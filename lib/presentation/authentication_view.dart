import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/states/providers/send_short_message_provider.dart';
import 'package:nomoca_flutter/states/providers/authentication_provider.dart';

class AuthenticationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認コード入力'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: _Form(),
      ),
    );
  }
}

class _Form extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authCode = useState('');
    var mobilePhoneNumber =
        ModalRoute.of(context)!.settings.arguments as String?;
    mobilePhoneNumber ??= '09011112222';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('確認コードを'),
                Text(mobilePhoneNumber),
                const Text('へ送信しました。'),
              ],
            ),
            const Text('続けるには4桁の確認コードを入力してください。'),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Form(
            key: _formKey,
            child: TextFormField(
              // initialValue: args.textFormFieldInitialValue(),
              maxLength: 4,
              decoration: const InputDecoration(
                hintText: '4桁の確認コードを入力',
                labelText: '確認コード',
              ),
              validator: (String? input) {
                return input == null || input.isEmpty ? '確認コードを入力してください' : null;
              },
              onSaved: (String? input) {
                authCode.value = input!;
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => _sendShortMessage(mobilePhoneNumber!, context),
          child: const Text('新しいコードを送信'),
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: () =>
              _submission(mobilePhoneNumber!, authCode.value, context),
          child: const Text('ログイン'),
        ),
        const Spacer(),
      ],
    );
  }

  void _submission(
      String mobilePhoneNumber, String authCode, BuildContext context) {
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // ユーザー認証実行
      final args = {
        'mobilePhoneNumber': mobilePhoneNumber,
        'authCode': authCode
      };
      context.read(authenticationProvider(args)).when(
        data: (_) async {
          // ローディング非表示
          await EasyLoading.dismiss();
          // 診察券画面へ遷移
          await Navigator.pushNamed(context, RouteNames.signIn,
              arguments: authCode);
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

  void _sendShortMessage(String mobilePhoneNumber, BuildContext context) {
    // 確認コード再送信
    context.read(sendShortMessageProvider(mobilePhoneNumber)).when(
      data: (_) async {
        // ローディング非表示
        // await EasyLoading.dismiss();
      },
      loading: () async {
        // ローディング表示
        // await EasyLoading.show();
      },
      error: (error, _) {
        // ローディング非表示
        // EasyLoading.dismiss();
        // SnackBar表示
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
    );
  }
}
