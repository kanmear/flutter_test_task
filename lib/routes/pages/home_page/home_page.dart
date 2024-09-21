import 'package:flutter/material.dart';

import 'package:live_beer/routes/pages/home_page/widgets/barcode_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(children: const [BarcodeCard()])),
      ),
    );
  }
}
