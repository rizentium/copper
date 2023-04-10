import 'package:copper_island/copper_island.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

part 'config_state.dart';
part 'config_cubit.g.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit({
    ThemeData? initialTheme,
  }) : super(ConfigState(chosenTheme: initialTheme ?? UITheme.lightblue));

  onSwitchTheme(ThemeData theme) {
    emit(state.copyWith(chosenTheme: theme));
  }
}
