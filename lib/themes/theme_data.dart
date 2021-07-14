import 'package:flutter/material.dart';

final _themeData = ThemeData(
  textTheme: const TextTheme(
    // ボタン全般のフォントサイズ
    button: TextStyle(fontSize: 16),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      // outlinedButtonの角丸設定
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // outlinedButtonの最小幅, 高さ
      minimumSize: const Size(88, 54),
    ),
  ),
);

final lightThemeData = _themeData.copyWith(
  primaryColor: Colors.white,
);

final darkThemeData = _themeData.copyWith();
