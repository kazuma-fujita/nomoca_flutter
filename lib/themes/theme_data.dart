import 'package:flutter/material.dart';

const _textTheme = TextTheme(
  // ボタン全般のフォントサイズ
  button: TextStyle(fontSize: 16),
);

final _outlinedButtonStyle = OutlinedButton.styleFrom(
  // outlinedButtonの角丸設定
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  // outlinedButtonの最小幅, 高さ。横幅は画面幅サイズとする。Viewで横幅調整
  minimumSize: const Size(double.infinity, 54),
);

final _lightOutlinedButtonTheme = OutlinedButtonThemeData(
  style: _outlinedButtonStyle.copyWith(
    // outlinedButtonのフォントカラー
    foregroundColor: MaterialStateProperty.all(Colors.black87),
    // outlinedButtonのボーダーカラー
    side: MaterialStateProperty.all(
      const BorderSide(color: Colors.black54, width: 1),
    ),
  ),
);

final _darkOutlinedButtonTheme = OutlinedButtonThemeData(
  style: _outlinedButtonStyle.copyWith(
    // outlinedButtonのフォントカラー
    foregroundColor: MaterialStateProperty.all(Colors.white70),
    // outlinedButtonのボーダーカラー
    side: MaterialStateProperty.all(
      const BorderSide(color: Colors.white54, width: 1),
    ),
  ),
);

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  // AppBarやTabBar、FloatingActionButtonなどアプリのメインとなるWidgetの背景色
  primaryColor: Colors.white,
  // AppBarのelevation無効
  appBarTheme: const AppBarTheme(elevation: 0),
  textTheme: _textTheme,
  outlinedButtonTheme: _lightOutlinedButtonTheme,
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  // AppBarのelevation無効
  appBarTheme: const AppBarTheme(elevation: 0),
  textTheme: _textTheme,
  outlinedButtonTheme: _darkOutlinedButtonTheme,
);
