import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:live_beer/routes/pages/home_page/widgets/news_view.dart';
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
      bottomNavigationBar: const BottomNavBar(),
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

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Theme(
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
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: localizations.homePageLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.info_outline),
              label: localizations.infoPageLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              label: localizations.shopPageLabel),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: localizations.profilePageLabel),
        ],
      ),
    );
  }
}
