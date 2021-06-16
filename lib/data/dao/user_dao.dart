import 'package:hive/hive.dart';
import 'package:nomoca_flutter/constants/db_table_names.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

abstract class UserDao {
  Future<void> save(User user);
  User? get();
}

class UserDaoImpl extends UserDao {
  final Box<User> _users = Hive.box<User>(DBTableNames.users);

  void _verifyDBStatus() {
    if (!_users.isOpen) {
      throw Exception('Table name ${DBTableNames.users} is not open.');
    }
    if (_users.length > 1) {
      throw Exception(
          'Table name ${DBTableNames.users} is more than one record.');
    }
  }

  @override
  Future<void> save(User user) async {
    _verifyDBStatus();
    if (_users.length == 0) {
      await _users.add(user);
    } else {
      final entity = _users.getAt(0);
      if (entity == null) {
        throw Exception('Table name ${DBTableNames.users} record is null.');
      }
      await _users.put(entity.key, user);
    }
  }

  @override
  User? get() {
    _verifyDBStatus();
    return _users.length == 1 ? _users.getAt(0) : null;
  }
}
