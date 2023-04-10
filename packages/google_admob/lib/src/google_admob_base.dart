import 'package:copper_island/copper_island.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:platform_interface/package_platform.dart';

class GoogleAdmob implements PackagePlatform {
  final List<String> testDeviceIds;

  GoogleAdmob({this.testDeviceIds = const []});

  @override
  Future<void> register(GetIt locator) async {
    locator.registerSingleton<MobileAds>(MobileAds.instance);
  }

  @override
  Future<void> onRegistered(GetIt locator) async {
    locator<MobileAds>().updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: testDeviceIds,
    ));
  }
}
