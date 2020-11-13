import 'package:flutter/material.dart';

class AppStyles {
  static const String primary_font = 'Poppins';
  static Color primary = new Color(0xff166FFF);
  static final ThemeData primaryTheme = ThemeData(
      primaryColor: primary,
      primaryColorLight: primary,
      accentColor: new Color(0xff9FBFF4),
      primaryColorDark: primary,
      fontFamily: primary_font);
}
