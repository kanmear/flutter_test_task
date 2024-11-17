import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:live_beer/state/home_page/liters_cubit.dart';
import 'package:live_beer/state/home_page/liters_state.dart';

class SavedLitersCard extends StatelessWidget {
  const SavedLitersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LitersCubit, LitersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text(state.error!));
        }

        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.colorScheme.onPrimary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Caps(savedAmount: state.liters),
                  const SizedBox(height: 16),
                  LitersInfo(savedAmount: state.liters),
                ],
              ),
            ),
            PresentDrawing(isPresentActive: state.liters == 10)
          ],
        );
      },
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
        child: TweenAnimationBuilder(
          tween: ColorTween(
              begin: theme.colorScheme.surface.withOpacity(0.4),
              end: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface.withOpacity(0.4)),
          duration: const Duration(milliseconds: 100),
          builder: (context, color, _) {
            return SvgPicture.asset(
              'assets/svg/cap.svg',
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
            );
          },
        ));
  }
}

class PresentDrawing extends StatelessWidget {
  final bool isPresentActive;

  const PresentDrawing({
    super.key,
    required this.isPresentActive,
  });

  @override
  Widget build(BuildContext context) {
    final blurColor = Theme.of(context).colorScheme.primary;

    return Positioned(
      top: -1,
      right: 4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => RadialGradient(
              colors: [
                blurColor.withOpacity(0.6),
                blurColor.withOpacity(0.0),
              ],
              center: Alignment.center,
              radius: 0.5,
            ).createShader(bounds),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isPresentActive ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            width: 80,
            child: SvgPicture.asset(
              'assets/svg/present.svg',
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(isPresentActive ? 1 : 0.4),
                  BlendMode.dstIn),
            ),
          )
        ],
      ),
    );
  }
}

class LitersInfo extends StatelessWidget {
  final int savedAmount;

  const LitersInfo({
    super.key,
    required this.savedAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.surface;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("$savedAmount/10",
                style: theme.textTheme.displayMedium!.apply(color: textColor)),
            const SizedBox(height: 4),
            Text(AppLocalizations.of(context)!.savedLiters,
                style: theme.textTheme.bodyMedium!.apply(color: textColor)),
          ]),
          const SizedBox(width: 16),
          VerticalDivider(
            indent: 8,
            endIndent: 4,
            thickness: 1,
            color: textColor.withOpacity(0.1),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(AppLocalizations.of(context)!.bonusLiter,
                textAlign: TextAlign.left,
                softWrap: true,
                style: theme.textTheme.labelSmall!.apply(color: textColor)),
          )
        ],
      ),
    );
  }
}
