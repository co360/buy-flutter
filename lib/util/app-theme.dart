import 'package:flutter/material.dart';

class AppTheme {
  static Color colorPrimary = Color(0xFF247BA0);
  static Color colorSuccess = Color(0xFF70C1B3);
  static Color colorWarning = Color(0xFFF3FFBD);
  static Color colorDanger = Color(0xFFEB547C);
  static Color colorInfo = Color(0xFFB2DBBF);
  static Color colorOrange = Color(0xFFF37318);
  static Color colorLink = Color(0xFF0093E9);

  static Color colorBg = Color(0xFFF9F9F9);
  static Color colorBg2 = Color(0xFFF3F5F8);

  static Color colorGray1 = Color(0xFFF8F9FA);
  static Color colorGray2 = Color(0xFFE9ECEF);
  static Color colorGray3 = Color(0xFFDEE2E6);
  static Color colorGray4 = Color(0xFFCED4DA);
  static Color colorGray5 = Color(0xFFADB5BD);
  static Color colorGray6 = Color(0xFF6C757D);
  static Color colorGray7 = Color(0xFF343A40);
  static Color colorGray8 = Color(0xFF343A40);
  static Color colorGray9 = Color(0xFF212529);

  static double paddingStandard = 20;

  static Widget gradientBackground = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
      ),
    ),
  );
}
