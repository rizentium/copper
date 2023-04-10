import 'package:get_it/get_it.dart';
import 'package:platform_interface/base_platform.dart';

abstract class PackagePlatform implements BasePlatform {
  Future<void> onRegistered(GetIt locator) async {
    throw UnimplementedError();
  }
}
