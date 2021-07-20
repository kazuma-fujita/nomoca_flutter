import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/states/arguments/authentication_provider_arguments.dart';
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

class _Form extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCode = useState('');
    final isResendAuthCode = useState(false);
    var mobilePhoneNumber =
        ModalRoute.of(context)!.settings.arguments as String?;
    mobilePhoneNumber ??= '09011112222';
    final sendShortMessageAsyncValue =
        ref.watch(sendShortMessageProvider(mobilePhoneNumber));
    final args = AuthenticationProviderArguments(
      mobilePhoneNumber: mobilePhoneNumber,
      authCode: authCode.value,
    );
    final authenticationAsyncValue = ref.watch(authenticationProvider(args));
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
          // authCode送信API実行中はボタンdisabled
          onPressed: isResendAuthCode.value
              ? null
              : () => _sendShortMessage(
                    mobilePhoneNumber!,
                    isResendAuthCode,
                    context,
                    sendShortMessageAsyncValue,
                  ),
          child: const Text('新しいコードを送信'),
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: () => _submission(
            context,
            authenticationAsyncValue,
          ),
          child: const Text('ログイン'),
        ),
        const Spacer(),
      ],
    );
  }

  void _submission(
    BuildContext context,
    AsyncValue<void> authenticationAsyncValue,
  ) {
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // ユーザー認証実行
      authenticationAsyncValue.when(
        data: (_) async {
          // ローディング非表示
          await EasyLoading.dismiss();
          // ログイン前画面のスタックを削除して診察券画面へ遷移
          await Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.patientCard,
            (r) => false,
          );
          // await Navigator.pushNamed(context, RouteNames.patientCard);
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

  void _sendShortMessage(
    String mobilePhoneNumber,
    ValueNotifier<bool> isResendAuthCode,
    BuildContext context,
    AsyncValue<void> sendShortMessageAsyncValue,
  ) {
    // 確認コード再送信
    sendShortMessageAsyncValue.when(
      data: (_) async {
        // 再送信ボタンenabled
        await Future.delayed(const Duration(seconds: 3));
        isResendAuthCode.value = false;
        print('send short message success');
      },
      loading: () {
        print('send short message loading');
        // 再送信ボタンdisable
        isResendAuthCode.value = true;
      },
      error: (error, _) {
        print('send short message error');
        // 再送信ボタンenabled
        isResendAuthCode.value = false;
        // SnackBar表示
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
    );
  }
}
