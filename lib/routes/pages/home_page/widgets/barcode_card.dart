import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/loading_indicator.dart';

class BarcodeCard extends StatelessWidget {
  const BarcodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 166,
        child: Column(
          children: [
            GreetingWidget(),
            BarcodeWidget(),
          ],
        ));
  }
}

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: theme.colorScheme.primary,
          ),
          child: Stack(
            children: [
              Center(
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
              ),
              SvgPicture.asset(
                'assets/svg/cones_clipped.svg',
                width: double.infinity,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    theme.colorScheme.onPrimary.withAlpha(20), BlendMode.dstIn),
              )
            ],
          )),
    );
  }

  Future<String> _getUsername() async {
    // await Future.delayed(const Duration(milliseconds: 250));
    return TextData.username;
  }
}

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: theme.colorScheme.surface,
              child: CustomPaint(painter: BarcodePainter()),
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder<String>(
              future: _getBarcode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else {
                  return JustifyBarcodeNumbers(barcode: snapshot.data!);
                }
              }),
        ],
      ),
    ));
  }

  Future<String> _getBarcode() async {
    // await Future.delayed(const Duration(milliseconds: 250));
    return '1234567010356443';
  }
}

class BarcodePainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double xPos = 0;

    while (xPos < size.width) {
      double lineWidth = random.nextDouble() * 7 + 1;
      double lineHeight = size.height;

      if (xPos + lineWidth > size.width) {
        lineWidth = size.width - xPos;
      }

      canvas.drawRect(
        Rect.fromLTWH(xPos, 0, lineWidth, lineHeight),
        paint,
      );
      xPos += lineWidth + random.nextDouble() * 5;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class JustifyBarcodeNumbers extends StatelessWidget {
  final String barcode;

  const JustifyBarcodeNumbers({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final arr = barcode.split('');

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (var s in arr) Text(s, style: theme.textTheme.headlineSmall)
    ]);
  }
}
