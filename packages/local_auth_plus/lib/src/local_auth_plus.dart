import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/types/auth_messages_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';
import 'package:local_auth_plus/src/local_auth_plus_storage_keys.dart';
import 'package:platform_interface/package_platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthPlus implements PackagePlatform {
  final LocalAuthentication? delegate;
  final SharedPreferences? storage;

  LocalAuthPlus({this.delegate, this.storage});

  Future<List<BiometricType>> availableBiometrics() async {
    final canCheckBiometrics = (await delegate?.canCheckBiometrics) ?? false;

    if (!canCheckBiometrics) return [];

    return (await delegate?.getAvailableBiometrics()) ?? [];
  }

  Future<bool> isDeviceSupported() async {
    return (await delegate?.isDeviceSupported()) ?? false;
  }

  Future<bool> didAuthenticate({
    required String localizedReason,
    required String signInTitle,
  }) async {
    final didAuthenticated = await delegate?.authenticate(
      localizedReason: localizedReason,
      authMessages: [
        AndroidAuthMessages(
          signInTitle: signInTitle,
          cancelButton: 'No thanks',
        ),
        const IOSAuthMessages(
          cancelButton: 'No thanks',
        ),
      ],
      options: const AuthenticationOptions(
        biometricOnly: false,
        stickyAuth: true,
      ),
    );
    return didAuthenticated ?? false;
  }

  bool? didAuthenticateActive() {
    final current = storage?.getBool(LocalAuthPlusStorageKeys.active);

    if (current == null) {
      return false;
    }
    return current;
  }

  Future<bool>? setAuthenticateActive(bool status) {
    return storage?.setBool(LocalAuthPlusStorageKeys.active, status);
  }

  @override
  Future<void> onRegistered(GetIt locator) async {}

  @override
  Future<void> register(GetIt locator) async {
    locator.registerSingleton<LocalAuthPlus>(
      LocalAuthPlus(
        delegate: LocalAuthentication(),
        storage: await SharedPreferences.getInstance(),
      ),
    );
  }
}
