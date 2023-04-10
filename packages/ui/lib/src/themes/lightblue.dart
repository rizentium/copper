import 'package:flutter/material.dart';

ThemeData get lightblueStyle {
  return ThemeData.light(
    useMaterial3: true,
  ).copyWith(primaryColor: Colors.blue);
}
