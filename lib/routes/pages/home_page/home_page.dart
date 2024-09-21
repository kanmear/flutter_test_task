import 'dart:math';

import 'package:flutter/material.dart';

import 'package:live_beer/routes/pages/home_page/widgets/news_view.dart';
import 'package:live_beer/routes/pages/home_page/widgets/points_card.dart';
import 'package:live_beer/routes/pages/home_page/widgets/barcode_card.dart';
import 'package:live_beer/routes/pages/home_page/widgets/saved_liters_card.dart';
import 'package:live_beer/text_data.dart';

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          unselectedLabelStyle: theme.textTheme.bodySmall,
          selectedLabelStyle: theme.textTheme.bodySmall,
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          unselectedItemColor: theme.colorScheme.onSecondary,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: TextData.homePageLabel),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline), label: TextData.infoPageLabel),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: TextData.shopPageLabel),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: TextData.profilePageLabel),
          ],
        ),
      ),
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
                const PointsCard(),
                const SizedBox(height: 24),
                const NewsView(),
                const SizedBox(height: 24),
              ]),
            )),
      ),
    );
  }
}
