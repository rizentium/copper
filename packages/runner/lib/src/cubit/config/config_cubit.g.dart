// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigStateCWProxy {
  ConfigState isLoading(bool isLoading);

  ConfigState chosenTheme(ThemeData chosenTheme);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigState(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigState call({
    bool? isLoading,
    ThemeData? chosenTheme,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfigState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfigState.copyWith.fieldName(...)`
class _$ConfigStateCWProxyImpl implements _$ConfigStateCWProxy {
  const _$ConfigStateCWProxyImpl(this._value);

  final ConfigState _value;

  @override
  ConfigState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ConfigState chosenTheme(ThemeData chosenTheme) =>
      this(chosenTheme: chosenTheme);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfigState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfigState(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfigState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? chosenTheme = const $CopyWithPlaceholder(),
  }) {
    return ConfigState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      chosenTheme:
          chosenTheme == const $CopyWithPlaceholder() || chosenTheme == null
              ? _value.chosenTheme
              // ignore: cast_nullable_to_non_nullable
              : chosenTheme as ThemeData,
    );
  }
}

extension $ConfigStateCopyWith on ConfigState {
  /// Returns a callable class that can be used as follows: `instanceOfConfigState.copyWith(...)` or like so:`instanceOfConfigState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigStateCWProxy get copyWith => _$ConfigStateCWProxyImpl(this);
}
