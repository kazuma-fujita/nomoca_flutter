import 'dart:math';

import 'package:nomoca_flutter/constants/asset_paths.dart';

mixin AssetImagePath {
  String getRandomInstitutionImagePath() {
    final random = Random();
    // assets/images/institutions/institution_default_1〜4.webpを表示
    // final randomValue = random.nextInt(5) + 1;
    final randomValue = random.nextInt(4) + 1;
    return '${AssetPaths.institutionImagePath}/institution_default_$randomValue.webp';
  }
}
