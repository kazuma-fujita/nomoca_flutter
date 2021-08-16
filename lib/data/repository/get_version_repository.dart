import 'dart:convert';

import 'package:nomoca_flutter/data/api/version_api.dart';
import 'package:nomoca_flutter/data/entity/remote/version_entity.dart';
import 'package:package_info/package_info.dart';

// ignore: one_member_abstracts
abstract class GetVersionRepository {
  Future<String> getVersion();
}

class GetVersionRepositoryImpl extends GetVersionRepository {
  GetVersionRepositoryImpl({required this.getVersionApi});

  final GetVersionApi getVersionApi;

  @override
  Future<String> getVersion() async {
    try {
      final responseBody = await getVersionApi();
      final decodedJson = json.decode(responseBody) as dynamic;
      // Conversion json to entity.
      final entity =
          VersionEntity.fromJson(decodedJson as Map<String, dynamic>);
      final appInfo = await PackageInfo.fromPlatform();
      return '${appInfo.version}.${appInfo.buildNumber}(${entity.version})';
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
