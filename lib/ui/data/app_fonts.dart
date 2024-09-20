import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class AppFonts {
  static TextTheme textTheme = TextTheme(
    titleLarge: roboto32Weight600,
  );

  static TextStyle roboto32Weight600 = TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600);
}
