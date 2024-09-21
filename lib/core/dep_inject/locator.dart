import 'package:get_it/get_it.dart';

import '/core/core.dart';

/// Global instance for reaching get it
final GetIt getIt = GetIt.instance;

/// initialize get it
Future<void> initLocator() async {
  // * Singleton
  getIt.registerSingletonAsync<IAuthService>(() async => AuthService());
  getIt.registerSingletonAsync<IHiveManager>(() async => HiveManager().init());
  getIt.registerSingletonAsync<ISharedPreferencesManager>(
      () async => SharedPreferencesManager().init());

  await getIt.allReady();
}
