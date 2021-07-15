import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/presentation/common/launch_url.dart';
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
                const SizedBox(height: 40),
                Column(
                  children: [
                    const Text('続行することでNOMOCaの'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => launchUrl(NomocaUrls.termsUrl),
                          child: const Text('利用規約'),
                        ),
                        const Text('と'),
                        TextButton(
                          onPressed: () =>
                              launchUrl(NomocaUrls.privacyPolicyUrl),
                          child: const Text('プライバシーポリシー'),
                        ),
                      ],
                    ),
                    const Text('に同意したことになります。'),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
