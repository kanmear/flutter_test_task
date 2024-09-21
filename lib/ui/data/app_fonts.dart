import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class AppFonts {
  static TextTheme textTheme = TextTheme(
    displayMedium: roboto32Weight800,
    titleLarge: roboto32Weight600,
    titleMedium: roboto32Weight300,
    titleSmall: roboto20Weight600,
    bodyLarge: roboto16Weight600,
    bodyMedium: roboto16Weight400,
    bodySmall: roboto12Weight300,
    labelMedium: roboto14Weight600,
    labelSmall: roboto14Weight400,
    headlineSmall: sf15Weight400,
  );

  static TextStyle sf15Weight400 =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  static TextStyle roboto32Weight800 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w800);

  static TextStyle roboto32Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600);
  static TextStyle roboto32Weight300 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w300);

  static TextStyle roboto20Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600);

  static TextStyle roboto16Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600);
  static TextStyle roboto16Weight400 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600);

  static TextStyle roboto14Weight400 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400);
  static TextStyle roboto14Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600);

  static TextStyle roboto12Weight300 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w300);
}
