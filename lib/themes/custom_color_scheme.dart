import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get logoPrimaryColor => brightness == Brightness.light
      ? const Color(0xff3a9ed2)
      : const Color(0xff3a9ed2);
  Color get logoPrimaryColorLight => brightness == Brightness.light
      ? const Color(0xffAAE7FF)
      : const Color(0xffAAE7FF);
}
