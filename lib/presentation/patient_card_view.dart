import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_mark.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_type.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/states/providers/patient_card_provider.dart';

class PatientCardView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = useProvider(patientCardProvider);
    return DefaultTabController(
      length: asyncValue is AsyncData ? asyncValue.data!.value.length : 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              const LogoMark(height: 96),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LogoType(height: 40),
                    Text(
                      '診察券',
                      style: TextStyle(fontSize: 40, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          toolbarHeight: 160,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            tabs: asyncValue is AsyncData
                ? asyncValue.data!.value
                    .map((PatientCardEntity entity) => Tab(
                          text: entity.nickname,
                        ))
                    .toList()
                : [],
          ),
        ),
        body: _PatientCardView(),
      ),
    );
  }
}

class _PatientCardView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return useProvider(patientCardProvider).when(
      data: (patientCardList) {
        // Stack Widgetで背景画像の上にQRコードを配置する
        return Stack(
          children: [
            // 背景画像
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      '${AssetPaths.backgroundImagePath}/bg_patient_card.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // QRコード
            TabBarView(
              children: patientCardList
                  .map(
                    (PatientCardEntity entity) =>
                        _TabPage(imageUrl: entity.qrCodeImageUrl),
                  )
                  .toList(),
            )
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => ErrorSnackBar(
        errorMessage: error.toString(),
        callback: () => context.refresh(patientCardProvider),
      ),
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, dynamic error) =>
                const Icon(Icons.error),
          ),
          const Text(
            '受付の際にこちらのQRコードを提示してください',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
