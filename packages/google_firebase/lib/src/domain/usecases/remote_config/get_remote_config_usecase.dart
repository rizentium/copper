import 'package:copper_island/copper_island.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:platform_interface/domain_platform.dart';

class GetRemoteConfigUsecase implements UsecasePlatform {
  final FirebaseRemoteConfig _config;

  GetRemoteConfigUsecase(GetIt locator) : _config = locator();

  RemoteConfigValue execute(String key) => _config.getValue(key);

  @override
  Future<void> register(GetIt locator) async {
    locator.registerSingleton<GetRemoteConfigUsecase>(
      GetRemoteConfigUsecase(locator),
    );
  }
}
