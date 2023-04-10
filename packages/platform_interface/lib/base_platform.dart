import 'package:copper_island/copper_island.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class BasePlatform extends PlatformInterface {
  BasePlatform() : super(token: _token);

  static final Object _token = Object();

  Future<void> register(GetIt locator) async {
    throw UnimplementedError();
  }
}
