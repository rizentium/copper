import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'copper_core_method_channel.dart';

abstract class CopperCorePlatform extends PlatformInterface {
  /// Constructs a CopperCorePlatform.
  CopperCorePlatform() : super(token: _token);

  static final Object _token = Object();

  static CopperCorePlatform _instance = MethodChannelCopperCore();

  /// The default instance of [CopperCorePlatform] to use.
  ///
  /// Defaults to [MethodChannelCopperCore].
  static CopperCorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CopperCorePlatform] when
  /// they register themselves.
  static set instance(CopperCorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
