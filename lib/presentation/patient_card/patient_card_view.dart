import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';

class PatientCardView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(patientCardViewModelProvider);
    return DefaultTabController(
      length: state is AsyncData ? state.data!.value.length : 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SvgPicture.asset(
                'assets/images/background/bg_patient_card_app_icon.svg',
                height: 120,
                color: const Color(0xffAAE7FF),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  'assets/images/background/bg_patient_card_app_logo.svg',
                  height: 60,
                  color: const Color(0xff3a9ed2),
                ),
              ),
            ],
          ),
          toolbarHeight: 168,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            tabs: state is AsyncData
                ? state.data!.value
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
    useEffect(() {
      print('useEffect');
      // 全てのWidgetのbuildが終わってからcallbackが呼ばれる
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        context.read(patientCardViewModelProvider.notifier).fetchList();
      });
      return () => print('dispose');
    }, const []);

    return context.read(patientCardViewModelProvider).when(
      data: (patientCardList) {
        print('fetch data. $patientCardList');
        // Stack Widgetで背景画像の上にQRコードを配置する
        return Stack(
          children: [
            // 背景画像
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background/bg_patient_card.webp'),
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
      loading: () {
        print('loading here');
        return Container();
      },
      error: (error, _) {
        print('error here $error');
        return Container();
      },
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
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
