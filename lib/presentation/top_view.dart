import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/themes/custom_color_scheme.dart';

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
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    SvgPicture.asset(
                      '${AssetPaths.backgroundImagePath}/bg_patient_card_app_icon.svg',
                      height: 128,
                      color:
                          Theme.of(context).colorScheme.logoPrimaryColorLight,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            '${AssetPaths.backgroundImagePath}/bg_patient_card_app_logo.svg',
                            height: 64,
                            color:
                                Theme.of(context).colorScheme.logoPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signIn);
                  },
                  child: const Text('ログイン'),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, RouteNames.signUp);
                  },
                  child: const Text('新規登録'),
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
