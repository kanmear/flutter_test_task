import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_beer/text_data.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.surface;

    const double paddings = 16;
    final halfOfContainerWidth =
        ((MediaQuery.of(context).size.width - paddings * 2) / 2).floor();

    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.colorScheme.onPrimary),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(paddings),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getRandomValue(),
                    style:
                        theme.textTheme.displayMedium!.apply(color: textColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    TextData.accumulatedPoint,
                    style: theme.textTheme.bodyMedium!.apply(color: textColor),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: halfOfContainerWidth.toDouble(),
                    child: Text(
                      TextData.collectPoints,
                      style: theme.textTheme.labelSmall!
                          .apply(color: textColor.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
            const BottlePicture(),
            const InfoButton()
          ],
        ),
      ),
    );
  }

  _getRandomValue() {
    final random = Random();
    return (random.nextInt(3017) + 1).toString();
  }
}

class BottlePicture extends StatelessWidget {
  const BottlePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      right: 1,
      top: 1,
      child: SvgPicture.asset(
        'assets/svg/bottles.svg',
        colorFilter:
            ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: -6,
        right: -6,
        child: SizedBox(
            height: 48,
            width: 48,
            child: SvgPicture.asset('assets/svg/question_circled.svg')));
  }
}
