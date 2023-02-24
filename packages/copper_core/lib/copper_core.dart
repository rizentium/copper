
import 'copper_core_platform_interface.dart';

class CopperCore {
  Future<String?> getPlatformVersion() {
    return CopperCorePlatform.instance.getPlatformVersion();
  }
}
