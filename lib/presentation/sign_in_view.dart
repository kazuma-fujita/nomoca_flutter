import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
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
              child: TextFormField(
                // initialValue: args.textFormFieldInitialValue(),
                maxLength: 11,
                decoration: const InputDecoration(
                  hintText: '携帯電話番号を入力してください',
                  labelText: '携帯電話番号',
                ),
                validator: (String? title) {
                  return title == null || title.isEmpty
                      ? '携帯電話番号を入力してください'
                      : null;
                },
                // onSaved: (String? title) {
                //   _nickname = title!;
                // },
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              child: const Text('確認コードを送信'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
