import 'package:flutter/material.dart';

import 'package:live_beer/routes/pages/authorization_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthorizationPage(),
    );
  }
}
