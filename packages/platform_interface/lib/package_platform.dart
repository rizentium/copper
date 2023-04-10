import 'package:copper_island/copper_island.dart';
import 'package:platform_interface/base_platform.dart';

abstract class PackagePlatform implements BasePlatform {
  Future<void> onRegistered(GetIt locator) async {
    throw UnimplementedError();
  }
}
