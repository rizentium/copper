import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'copper_core_platform_interface.dart';

/// An implementation of [CopperCorePlatform] that uses method channels.
class MethodChannelCopperCore extends CopperCorePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('copper_core');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
