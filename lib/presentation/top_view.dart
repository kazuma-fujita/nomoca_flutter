import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/presentation/components/atoms/outlined_white_button.dart';
import 'package:nomoca_flutter/presentation/components/molecules/logo.dart';

class TopView extends StatelessWidget {
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
                const Spacer(),
                const Logo(logoMarkHeight: 128, logoTypeHeight: 64),
                const Spacer(),
                OutlinedWhiteButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  label: 'ログイン',
                ),
                const SizedBox(height: 32),
                OutlinedWhiteButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  label: '新規登録',
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
