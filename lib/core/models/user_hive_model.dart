import 'package:hive_flutter/hive_flutter.dart';

part 'user_hive_model.g.dart';

@HiveType(
  typeId: 0,
  adapterName: 'UserHiveModelAdapter',
)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? displayName;
  @HiveField(3)
  final String? photoURL;

  UserHiveModel(
      {required this.uid,
      required this.email,
      required this.displayName,
      required this.photoURL});
}
