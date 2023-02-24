import 'package:flutter_test/flutter_test.dart';
import 'package:copper_core/copper_core.dart';
import 'package:copper_core/copper_core_platform_interface.dart';
import 'package:copper_core/copper_core_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCopperCorePlatform
    with MockPlatformInterfaceMixin
    implements CopperCorePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CopperCorePlatform initialPlatform = CopperCorePlatform.instance;

  test('$MethodChannelCopperCore is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCopperCore>());
  });

  test('getPlatformVersion', () async {
    CopperCore copperCorePlugin = CopperCore();
    MockCopperCorePlatform fakePlatform = MockCopperCorePlatform();
    CopperCorePlatform.instance = fakePlatform;

    expect(await copperCorePlugin.getPlatformVersion(), '42');
  });
}
