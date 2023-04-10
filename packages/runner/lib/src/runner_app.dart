import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/config/config_cubit.dart';

class RunnerApp extends StatelessWidget {
  final String title;
  final ThemeData? theme;
  final bool debugShowCheckedModeBanner;
  final RouterConfig<Object>? routerConfig;

  const RunnerApp({
    super.key,
    required this.title,
    this.theme,
    this.routerConfig,
    this.debugShowCheckedModeBanner = true,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigCubit(initialTheme: theme),
      child: BlocBuilder<ConfigCubit, ConfigState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            title: title,
            theme: state.chosenTheme,
            routerConfig: routerConfig,
          );
        },
      ),
    );
  }
}
