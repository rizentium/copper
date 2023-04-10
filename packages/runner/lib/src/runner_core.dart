import 'package:copper_island/copper_island.dart';
import 'package:flutter/material.dart';
import 'package:platform_interface/data_platform.dart';
import 'package:platform_interface/domain_platform.dart';
import 'package:platform_interface/feature_platform.dart';
import 'package:platform_interface/package_platform.dart';

import 'runner_app.dart';

GetIt locator = GetIt.instance;

class Runner {
  static Future<RunnerApp> initialize({
    String title = '',
    ThemeData? theme,
    bool debugShowCheckedModeBanner = true,
    required List<PackagePlatform> packages,
    required DataPlatform data,
    required DomainPlatform domain,
    required List<FeaturePlatform> features,
    String initialLocation = '/',
  }) async {
    // Packages registration
    await Future.wait(packages.map((e) => e.register(locator)));
    await Future.wait(packages.map((e) => e.onRegistered(locator)));

    // Domain registration
    await data.register(locator);

    // Domain registration
    await domain.register(locator);

    // Feature registration
    await Future.wait(features.map((e) => e.register(locator)));

    // Merge all routes for plugins and features into one list
    final routes = [
      ...features.map((e) => e.routes.map((e) => e.route).toList()),
    ].fold<List<GoRoute>>([], (prev, el) => [...prev, ...el]);

    return RunnerApp(
      title: title,
      theme: theme,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      routerConfig: GoRouter(
        routes: routes,
        initialLocation: initialLocation,
      ),
    );
  }
}
