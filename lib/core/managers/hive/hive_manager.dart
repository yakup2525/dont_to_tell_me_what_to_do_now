import 'package:hive_flutter/hive_flutter.dart';

import '/core/core.dart';

abstract class IHiveManager {
  Box get user;

  Future init();
  Future<void> close();
  Future<bool> boxExists({required String boxName});
  Future<void> removeBox({required String boxName});
}

final class HiveManager implements IHiveManager {
  @override
  Box get user => _user;
  late Box _user;

  @override
  Future<HiveManager> init() async {
    //Hive'i projemize tanımladık ve kurduk
    await Hive.initFlutter();

    //Modellerimizi hive'e özel olarak tanıtmak için Hive.registerAdapter
    Hive.registerAdapter(UserHiveModelAdapter());

//Uygulamada tekrar kullancaksak boxları kapatmayı gerekli bulmuyorum
    _user = await Hive.openBox('userBox');

    return this;
  }

  Future<void> boxInit(String boxName) async {
    await Hive.openBox(boxName);
  }
  // Box _box = Hive.box(boxName); ile açılan box gerekli yerde çağrılabilir.

  @override
  Future<void> close() async {
    await Hive.close();
  }

  @override
  Future<bool> boxExists({required String boxName}) async {
    return await Hive.boxExists(boxName);
  }

  @override
  Future<void> removeBox({required String boxName}) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
