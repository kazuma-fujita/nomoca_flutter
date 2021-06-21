import 'dart:math';

import 'package:nomoca_flutter/constants/asset_paths.dart';

mixin AssetImagePath {
  String getRandomInstitutionImagePath() {
    final random = Random();
    final randomValue = random.nextInt(5) + 1;
    return '${AssetPaths.institutionImagePath}/institution_default_$randomValue.webp';
  }
}
