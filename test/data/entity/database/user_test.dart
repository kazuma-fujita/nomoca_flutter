import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:nomoca_flutter/constants/db_table_names.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

Future<void> main() async {
  setUpAll(() async {
    // DB 初期化
    final path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter<User>(UserAdapter());
  });

  tearDownAll(() async {
    // 全テスト完了後、全テーブルのレコード削除、DB Close.
    await Hive.deleteFromDisk();
    await Hive.close();
  });

  setUp(() async {
    // Daoシングルトンインスタンス生成
    await Hive.openBox<User>(DBTableNames.users);
  });

  tearDown(() async {
    // テスト毎にusersテーブルのレコード削除
    await Hive.deleteBoxFromDisk(DBTableNames.users);
  });

  group('Testing database table of user.', () {
    test('Testing create of user data.', () async {
      // openBoxした後はbox()で既に開いているDaoシングルトンインスタンスを取得できる
      final users = Hive.box<User>(DBTableNames.users);
      expect(users.length, 0);
      // Createするバリューオブジェクト
      final user = User()
        ..userId = 1
        ..authenticationToken = 'dummyAuthToken'
        ..nickname = '太郎'
        ..fcmToken = 'dummyFcmToken';
      // keyはincrementされるユニーク値
      expect(user.key, isNull);
      // Create
      await users.add(user);
      // Create後にユニークな値が発番される
      expect(user.key, 0);
      expect(users.length, 1);
      // getAt()で添字アクセスが出来る
      expect(
        users.getAt(0),
        isA<User>()
            .having((user) => user.userId, 'userId', 1)
            .having((user) => user.authenticationToken, 'authToken',
                'dummyAuthToken')
            .having((user) => user.nickname, 'nickname', '太郎')
            .having((user) => user.fcmToken, 'fchToken', 'dummyFcmToken'),
      );
      // get()でユニークkeyアクセスも可能
      expect(
        users.get(user.key),
        isA<User>()
            .having((user) => user.userId, 'userId', 1)
            .having((user) => user.authenticationToken, 'authToken',
                'dummyAuthToken')
            .having((user) => user.nickname, 'nickname', '太郎')
            .having((user) => user.fcmToken, 'fchToken', 'dummyFcmToken'),
      );
    });

    test('Testing update of user data.', () async {
      final users = Hive.box<User>(DBTableNames.users);
      expect(users.length, 0);
      // Createするバリューオブジェクト
      final user = User()..nickname = '太郎';
      expect(user.key, isNull);
      // Create
      await users.add(user);
      expect(user.key, 0);
      expect(users.length, 1);
      // レコードが作成されていることを確認
      expect(
        users.get(user.key),
        isA<User>()
            .having((user) => user.userId, 'userId', isNull)
            .having((user) => user.authenticationToken, 'authToken', isNull)
            .having((user) => user.nickname, 'nickname', '太郎')
            .having((user) => user.fcmToken, 'fchToken', isNull),
      );

      // Update
      user.nickname = '次郎';
      await user.save();

      // レコードが更新されていることを確認
      expect(
        users.get(user.key),
        isA<User>()
            .having((user) => user.userId, 'userId', isNull)
            .having((user) => user.authenticationToken, 'authToken', isNull)
            .having((user) => user.nickname, 'nickname', '次郎')
            .having((user) => user.fcmToken, 'fchToken', isNull),
      );
    });
    test('Testing delete of user data.', () async {
      final users = Hive.box<User>(DBTableNames.users);
      expect(users.length, 0);
      // Createするバリューオブジェクト
      final user = User()..nickname = '太郎';
      expect(user.key, isNull);
      // Create
      await users.add(user);
      expect(user.key, 0);
      expect(users.length, 1);
      // レコードが作成されていることを確認
      expect(
        users.get(user.key),
        isA<User>()
            .having((user) => user.userId, 'userId', isNull)
            .having((user) => user.authenticationToken, 'authToken', isNull)
            .having((user) => user.nickname, 'nickname', '太郎')
            .having((user) => user.fcmToken, 'fchToken', isNull),
      );

      // Delete
      await user.delete();

      // レコードが削除されていることを確認
      expect(user.key, isNull);
      expect(users.length, 0);
    });
  });
}
