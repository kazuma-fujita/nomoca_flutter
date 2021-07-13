import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('${AssetPaths.backgroundImagePath}/bg_top.webp'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Welcome message
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                const Text(
                  'ご入力頂いた電話番号宛に確認コードが記載されたSMSを送信します',
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                TextFormField(
                  // initialValue: args.textFormFieldInitialValue(),
                  maxLength: 20,
                  // maxLength以上入力不可
                  // maxLengthEnforced: true,
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
                Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () {},
                  child: const Text('確認コードを送信'),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
