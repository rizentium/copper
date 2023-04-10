part of 'config_cubit.dart';

@immutable
@CopyWith()
class ConfigState {
  final bool isLoading;
  final ThemeData chosenTheme;

  const ConfigState({
    this.isLoading = false,
    required this.chosenTheme,
  });
}
