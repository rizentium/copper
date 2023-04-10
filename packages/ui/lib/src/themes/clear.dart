import 'package:flutter/material.dart';

ThemeData get clearStyle {
  return ThemeData(
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.black,
      color: Colors.transparent,
      elevation: 0.0,
      shape: Border(
        bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black.withOpacity(0.7),
      unselectedItemColor: Colors.black26,
      showUnselectedLabels: false,
    ),
  );
}
