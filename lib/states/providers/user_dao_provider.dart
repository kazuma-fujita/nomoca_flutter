import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/constants/db_table_names.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/database/user.dart';

final userDaoProvider = Provider(
  (_) => UserDaoImpl(Hive.box<User>(DBTableNames.users)),
);
