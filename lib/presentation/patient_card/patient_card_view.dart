import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/data/entity/remote/patient_card_entity.dart';
import 'package:nomoca_flutter/main.dart';
import 'package:nomoca_flutter/presentation/patient_card/patient_card_view_model.dart';

class PatientCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = context.read(patientCardProvider);
    return DefaultTabController(
      length: asyncValue is AsyncData ? asyncValue.data!.value.length : 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SvgPicture.asset(
                '${AssetPaths.backgroundImagePath}/bg_patient_card_app_icon.svg',
                height: 96,
                color: const Color(0xffAAE7FF),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      '${AssetPaths.backgroundImagePath}/bg_patient_card_app_logo.svg',
                      height: 40,
                      color: const Color(0xff3a9ed2),
                    ),
                    const Text(
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
        body: _PatientCardView(asyncValue: asyncValue),
      ),
    );
  }
}

class _PatientCardView extends StatelessWidget {
  const _PatientCardView({required this.asyncValue});
  final AsyncValue<List<PatientCardEntity>> asyncValue;

  @override
  Widget build(BuildContext context) {
    // useEffect(() {
    //   print('useEffect');
    //   // 全てのWidgetのbuildが終わってからcallbackが呼ばれる
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     context.read(patientCardViewModelProvider.notifier).fetchList();
    //   });
    //   return () => print('dispose');
    // }, const []);
    return asyncValue.when(
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
      loading: () {
        print('loading here');
        return Container();
      },
      error: (error, _) {
        print('error here $error');
        return ErrorSnackBar(
          buildContext: context,
          errorMessage: error.toString(),
        );
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

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({required this.buildContext, required this.errorMessage});
  final BuildContext buildContext;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      duration: const Duration(days: 365),
      action: SnackBarAction(
        label: '再試行',
        onPressed: () {
          // 一覧取得
          buildContext.read(patientCardProvider.future);
          // snackBar非表示
          ScaffoldMessenger.of(buildContext).removeCurrentSnackBar();
        },
      ),
    );
    // 全Widgetのbuild後にsnackBarを表示させる
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(buildContext).showSnackBar(snackBar);
    });
    return Container();
  }
}

Widget _errorView(String errorMessage) {
  final context = useContext();
  final snackBar = SnackBar(
    content: Text(errorMessage),
    duration: const Duration(days: 365),
    action: SnackBarAction(
      label: '再試行',
      onPressed: () {
        // 一覧取得
        context.read(patientCardProvider);
        // snackBar非表示
        // _scaffoldKey.currentState.removeCurrentSnackBar();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // 全Widgetのbuild後にsnackBarを表示させる
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // });
  return Container();
}
