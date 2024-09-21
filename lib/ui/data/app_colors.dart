import 'package:flutter/material.dart';

class AppColors {
  static const Color lightSurface0 = Color(0xffFFFFFF);

  static const Color lightPrimary = Color(0xffFFE100);
  static const Color lightOnPrimary = Color(0xff08070C);

  static const Color lightSecondary = Color(0xffF0F0F0);
  static const Color lightOnSecondary = Color(0xff8E8E93);

  static const Color lightSurfLowest = Color(0xffD1D1D6);
  static const Color lightSurfLow = Color(0xffF5F5F5);
  static const Color lightSurfHighest = Color(0xff242223);

  static const Color tertiary = Color(0xff007AFF);
  static const Color error = Color(0xffFF0000);

  static ColorScheme lightColorScheme = const ColorScheme(
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    surface: lightSurface0,
    onSurface: lightPrimary,
    surfaceContainerLowest: lightSurfLowest,
    surfaceContainerLow: lightSurfLow,
    surfaceContainerHighest: lightSurfHighest,
    error: error,
    onError: lightOnPrimary,
    tertiary: tertiary,
    brightness: Brightness.light,
  );
}
