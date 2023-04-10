import 'package:flutter/material.dart';

ThemeData get notulenStyle {
  return ThemeData(
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        ),
      ),
    ),
  );
}
