import 'package:flutter/material.dart';

ThemeData get lightgreenStyle {
  return ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
  );
}
