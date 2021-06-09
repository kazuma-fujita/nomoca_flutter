import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void initEasyLoading() {
  EasyLoading.instance
    ..indicatorSize = 64
    ..userInteractions = false
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(0.1)
    ..textColor = Colors.black
    ..indicatorColor = Colors.black
    ..backgroundColor = Colors.white;
}
