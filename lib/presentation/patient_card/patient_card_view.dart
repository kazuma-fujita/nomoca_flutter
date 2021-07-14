import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/data/api/patient_card_api.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/data/repository/patient_card_repository.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_mark.dart';
import 'package:nomoca_flutter/presentation/components/atoms/logo_type.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/presentation/components/molecules/logo.dart';

final patientCardApiProvider = Provider.autoDispose(
  (ref) => PatientCardApiImpl(
    apiClient: ref.read(apiClientProvider),
  ),
);

final patientCardRepositoryProvider =
    Provider.autoDispose<PatientCardRepository>(
  (ref) => PatientCardRepositoryImpl(
    patientCardApi: ref.read(patientCardApiProvider),
    userDao: ref.read(userDaoProvider),
  ),
);

final patientCardState =
    FutureProvider.autoDispose<List<PatientCardEntity>>((ref) async {
  return ref.read(patientCardRepositoryProvider).fetchList();
});

class PatientCardView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = useProvider(patientCardState);
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
    return useProvider(patientCardState).when(
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
        callback: () => context.refresh(patientCardState),
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
