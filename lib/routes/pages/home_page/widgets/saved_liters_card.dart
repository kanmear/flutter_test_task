import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedLitersCard extends StatelessWidget {
  final int liters;

  const SavedLitersCard({super.key, required this.liters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 178,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.onPrimary),
      child: Column(
        children: [
          Caps(savedAmount: liters),
        ],
      ),
    );
  }
}

class Caps extends StatelessWidget {
  final int savedAmount;

  const Caps({super.key, required this.savedAmount});

  @override
  Widget build(BuildContext context) {
    final List<int> capsInRow = [1, 2, 3, 4, 5];

    return Column(
      children: [
        Row(children: [
          for (var i in capsInRow)
            Row(
              children: [
                CapIcon(
                  isActive: i <= savedAmount,
                ),
                const SizedBox(width: 4)
              ],
            )
        ]),
        const SizedBox(height: 4),
        Row(children: [
          for (var i in capsInRow)
            Row(
              children: [
                CapIcon(
                  isActive: i + 5 <= savedAmount,
                ),
                const SizedBox(width: 4)
              ],
            )
        ]),
      ],
    );
  }
}

class CapIcon extends StatelessWidget {
  final bool isActive;

  const CapIcon({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
        height: 38,
        width: 38,
        child: SvgPicture.asset(
          'assets/svg/cap.svg',
          fit: BoxFit.fill,
          colorFilter:
              ColorFilter.mode(_resolveColor(theme), BlendMode.modulate),
        ));
  }

  _resolveColor(ThemeData theme) {
    return isActive
        ? theme.colorScheme.primary
        : theme.colorScheme.surface.withOpacity(0.4);
  }
}
