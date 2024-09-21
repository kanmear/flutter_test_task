import 'package:flutter/material.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/loading_indicator.dart';

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

class BarcodeCard extends StatelessWidget {
  const BarcodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
        height: 166,
        child: Column(
          children: [
            Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: theme.colorScheme.primary,
                ),
                child: Center(
                  child: FutureBuilder<String>(
                    future: _getUsername(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingIndicator();
                      } else {
                        final username = snapshot.data!;
                        return Text(
                          TextData.helloUser(username),
                          style: theme.textTheme.titleSmall,
                        );
                      }
                    },
                  ),
                )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: theme.colorScheme.surface,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 46,
                    color: theme.colorScheme.tertiary,
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<String>(
                      future: _getBarcode(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingIndicator();
                        } else {
                          final barcode = snapshot.data!;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var s in barcode.split(''))
                                Text(
                                  s,
                                  style: theme.textTheme.titleSmall,
                                )
                            ],
                          );
                        }
                      }),
                ],
              ),
            ))
          ],
        ));
  }

  Future<String> _getUsername() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return TextData.username;
  }

  Future<String> _getBarcode() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return '1234567010356443';
  }
}
