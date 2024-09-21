import 'package:flutter/material.dart';

import 'package:live_beer/ui/data/app_fonts.dart';
import 'package:live_beer/ui/data/app_colors.dart';

import 'package:live_beer/routes/pages/authorization_page.dart';

import 'package:live_beer/utils.dart';

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
      home: Builder(builder: (context) {
        return Utils.wrapWithTheme(context, AuthorizationPage());
      }),
    );
  }
}
