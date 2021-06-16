import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  // User(this.userId, this.authenticationToken, this.nickname, this.fcmToken);
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? authenticationToken;
  @HiveField(2)
  String? nickname;
  @HiveField(3)
  String? fcmToken;
}
