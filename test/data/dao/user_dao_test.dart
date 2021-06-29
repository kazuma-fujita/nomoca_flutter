@Skip('currently failing')
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:nomoca_flutter/constants/db_table_names.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

Future<void> main() async {
  late UserDao _dao;
  late Box<User> _users;

  setUpAll(() async {
    // DB 初期化処理
    final path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter<User>(UserAdapter());
    // Daoシングルトンインスタンス生成
    await Hive.openBox<User>(DBTableNames.users);
  });

  tearDownAll(() async {
    // 全テスト完了後、全テーブルのレコード削除、DB Close.
    await Hive.deleteFromDisk();
    await Hive.close();
  });

  setUp(() async {
    // openBoxした後はbox()で既に開いているDaoシングルトンインスタンスを取得できる
    _users = Hive.box(DBTableNames.users);
    _dao = UserDaoImpl(_users);
  });

  tearDown(() async {
    // テスト毎にusersテーブルのレコード削除
    await Hive.deleteBoxFromDisk(DBTableNames.users);
  });

  group('Testing dao of user.', () {
    test('Testing save method.', () async {
      expect(_users.length, 0);
      // Createするバリューオブジェクト
      final user = User()
        ..userId = 1
        ..authenticationToken = 'dummyAuthToken'
        ..nickname = '太郎'
        ..fcmToken = 'dummyFcmToken';
      // keyはincrementされるユニーク値
      expect(user.key, isNull);
      // Create
      await _dao.save(user);
      // Create後にユニークな値が発番される
      expect(user.key, 0);
      expect(_users.length, 1);
      // daoのgetでユニークなレコードを取得
      expect(
        _dao.get(),
        isA<User>()
            .having((user) => user.userId, 'userId', 1)
            .having((user) => user.authenticationToken, 'authToken',
                'dummyAuthToken')
            .having((user) => user.nickname, 'nickname', '太郎')
            .having((user) => user.fcmToken, 'fchToken', 'dummyFcmToken'),
      );
      // ニックネームを別の名前に設定
      user.nickname = '次郎';
      // Update
      await _dao.save(user);
      // daoのgetでユニークなレコードを取得
      expect(
        _dao.get(),
        isA<User>()
            .having((user) => user.userId, 'userId', 1)
            .having((user) => user.authenticationToken, 'authToken',
                'dummyAuthToken')
            .having((user) => user.nickname, 'nickname', '次郎')
            .having((user) => user.fcmToken, 'fchToken', 'dummyFcmToken'),
      );
    });
  });
}
