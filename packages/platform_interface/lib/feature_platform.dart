import 'package:copper_island/copper_island.dart';
import 'package:platform_interface/base_platform.dart';

abstract class FeaturePlatform implements BasePlatform {
  List<RoutePlatform> get routes {
    throw UnimplementedError();
  }
}

abstract class RoutePlatform implements BasePlatform {
  GoRoute get route {
    throw UnimplementedError();
  }
}
