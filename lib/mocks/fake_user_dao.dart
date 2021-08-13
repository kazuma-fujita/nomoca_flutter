import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

class FakeUserDaoImpl extends UserDao {
  FakeUserDaoImpl();

  @override
  User? get() {
    // ログイン前画面検証時はnullを返却
    // return null;
    // ログイン後画面検証時はUserインスタンスを返却
    return User()
      ..authenticationToken = 'dummyToken'
      ..userId = 9999
      ..nickname = '次郎太';
  }

  @override
  Future<void> save(User user) {
    throw UnimplementedError();
  }
}
