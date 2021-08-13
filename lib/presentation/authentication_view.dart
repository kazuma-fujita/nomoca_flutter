import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/states/providers/authentication_provider.dart';
import 'package:nomoca_flutter/states/providers/send_short_message_provider.dart';

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

    // 再送信ボタン押下時処理
    ref.watch(sendShortMessageProvider).when(
      data: (isSuccess) async {
        if (isSuccess) {
          // 再送信ボタンenabled
          // await Future.delayed(const Duration(seconds: 3));
          isResendAuthCode.value = false;
        }
      },
      loading: () async {
        // 再送信ボタンdisable
        isResendAuthCode.value = true;
      },
      error: (error, _) {
        // 再送信ボタンenabled
        isResendAuthCode.value = false;
        // SnackBar表示
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      },
    );

    // ボタン押下時処理
    final asyncValue = ref.watch(authenticationProvider)
      ..when(
        data: (isSuccess) async {
          if (isSuccess) {
            // ローディング非表示
            await EasyLoading.dismiss();
            // ログイン前画面のスタックを削除して診察券画面へ遷移
            await Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.patientCard,
              (r) => false,
            );
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
              : () => ref
                  .read(sendShortMessageProvider.notifier)
                  .sendShortMessage(mobilePhoneNumber: mobilePhoneNumber!),
          child: const Text('新しいコードを送信'),
        ),
        const Spacer(),
        OutlinedButton(
          // 読み込み中はボタンdisabled
          onPressed: () => asyncValue is AsyncLoading
              ? null
              : _submission(mobilePhoneNumber!, authCode, ref),
          child: const Text('ログイン'),
        ),
        const Spacer(),
      ],
    );
  }

  void _submission(
    String mobilePhoneNumber,
    ValueNotifier<String> authCode,
    WidgetRef ref,
  ) {
    // TextFormFieldのvalidate実行
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(authenticationProvider.notifier).authentication(
            mobilePhoneNumber: mobilePhoneNumber,
            authCode: authCode.value,
          );
    }
  }
}
