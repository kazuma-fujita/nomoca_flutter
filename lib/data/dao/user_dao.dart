import 'package:hive/hive.dart';
import 'package:nomoca_flutter/constants/db_table_names.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

abstract class UserDao {
  Future<void> save(User user);
  User? get();
}

class UserDaoImpl extends UserDao {
  // final Box<User> _users = Hive.box<User>(DBTableNames.users);
  UserDaoImpl(this.users);

  final Box<User> users;

  void _verifyDBStatus() {
    if (!users.isOpen) {
      throw Exception('Table name ${DBTableNames.users} is not open.');
    }
    if (users.length > 1) {
      throw Exception(
          'Table name ${DBTableNames.users} is more than one record.');
    }
  }

  @override
  Future<void> save(User user) async {
    _verifyDBStatus();
    if (users.length == 0) {
      await users.add(user);
    } else {
      final entity = users.getAt(0);
      if (entity == null) {
        throw Exception('Table name ${DBTableNames.users} record is null.');
      }
      await users.put(entity.key, user);
    }
  }

  @override
  User? get() {
    _verifyDBStatus();
    return users.length == 1 ? users.getAt(0) : null;
  }
}
