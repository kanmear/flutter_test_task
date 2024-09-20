import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final List<Listenable> listenables;
  final Function isActive;
  final Function onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
    required this.listenables,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            visualDensity: VisualDensity.compact),
        onPressed: () => _resolveAction(),
        child: AnimatedBuilder(
          animation: Listenable.merge(listenables),
          builder: (BuildContext context, Widget? child) {
            final theme = Theme.of(context);

            final buttonColor = _resolveColor(theme);

            return Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  text,
                  style: _resolveStyle(theme),
                  textAlign: TextAlign.center,
                ));
          },
        ));
  }

  _resolveAction() => isActive() ? onTap() : {};

  _resolveColor(ThemeData theme) =>
      isActive() ? theme.colorScheme.primary : theme.colorScheme.secondary;

  _resolveStyle(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;

    return isActive()
        ? theme.textTheme.bodyLarge!.apply(color: color)
        : theme.textTheme.bodyLarge!.apply(color: color.withOpacity(0.2));
  }
}
