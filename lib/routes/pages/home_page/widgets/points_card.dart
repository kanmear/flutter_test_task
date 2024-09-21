import 'dart:math';

import 'package:flutter/material.dart';
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

    return Container(
      padding: const EdgeInsets.all(paddings),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.onPrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getRandomValue(),
            style: theme.textTheme.displayMedium!.apply(color: textColor),
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
    );
  }

  _getRandomValue() {
    final random = Random();
    return (random.nextInt(3017) + 1).toString();
  }
}
