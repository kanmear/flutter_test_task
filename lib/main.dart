import 'package:flutter/material.dart';

import 'package:live_beer/routes/pages/authorization_page.dart';

import 'package:live_beer/ui/data/app_colors.dart';
import 'package:live_beer/ui/data/app_fonts.dart';

void main() {
  runApp(const LiveBeerApp());
}

class LiveBeerApp extends StatelessWidget {
  const LiveBeerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveBeer',
      theme: ThemeData(
        colorScheme: AppColors.lightColorScheme,
        textTheme: AppFonts.textTheme,
      ),
      home: const AuthorizationPage(),
    );
  }
}
