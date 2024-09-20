import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class AppFonts {
  static TextTheme textTheme = TextTheme(
    titleLarge: roboto32Weight600,
    labelMedium: roboto14Weight600,
    labelSmall: roboto14Weight400,
  );

  static TextStyle roboto32Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600);

  static TextStyle roboto14Weight400 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400);
  static TextStyle roboto14Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600);
}
