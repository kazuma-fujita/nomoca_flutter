import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/presentation/common/launch_url.dart';
import 'package:nomoca_flutter/presentation/components/atoms/outlined_white_button.dart';

class QrReadSelectUserTypeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    '${AssetPaths.backgroundImagePath}/bg_qr_read.webp'),
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
                Column(
                  children: const [
                    Text(
                      '医療機関により発行された',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'QRコードをスキャンして病院を追加します',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'どなたの診察券QRコードをスキャンしますか？',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                OutlinedWhiteButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  label: '家族の診察券',
                ),
                const SizedBox(height: 32),
                OutlinedWhiteButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  label: '自分の診察券',
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    TextButton(
                      onPressed: () => launchUrl(NomocaUrls.termsUrl),
                      child: const Text(
                        'スキップする',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'プロフィールからいつでもQRコードを読み取ることができます',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
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
