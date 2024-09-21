import 'dart:math';

import 'package:flutter/material.dart';

import 'package:live_beer/routes/pages/home_page/widgets/points_card.dart';
import 'package:live_beer/routes/pages/home_page/widgets/barcode_card.dart';
import 'package:live_beer/routes/pages/home_page/widgets/saved_liters_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int liters;

  @override
  void initState() {
    super.initState();
    liters = Random().nextInt(10) + 1;
  }

  Future<void> _refreshLiters() async {
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() => liters = Random().nextInt(10) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondary,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: RefreshIndicator(
              color: theme.colorScheme.onPrimary,
              onRefresh: _refreshLiters,
              child: ListView(children: [
                const BarcodeCard(),
                const SizedBox(height: 8),
                SavedLitersCard(liters: liters),
                const SizedBox(height: 8),
                const PointsCard()
              ]),
            )),
      ),
    );
  }
}
