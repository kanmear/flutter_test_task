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
    return AnimatedBuilder(
        animation: Listenable.merge(listenables),
        builder: (BuildContext context, Widget? child) {
          final theme = Theme.of(context);

          return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: _resolveColor(theme),
                overlayColor: _resolveOverlayColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero),
            onPressed: () => _resolveAction(),
            child: Container(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              width: double.infinity,
              child: Text(
                text,
                style: _resolveStyle(theme),
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }

  _resolveAction() => isActive() ? onTap() : {};

  _resolveOverlayColor() => isActive() ? Colors.black : Colors.transparent;

  _resolveColor(ThemeData theme) =>
      isActive() ? theme.colorScheme.primary : theme.colorScheme.secondary;

  _resolveStyle(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;

    return isActive()
        ? theme.textTheme.bodyLarge!.apply(color: color)
        : theme.textTheme.bodyLarge!.apply(color: color.withOpacity(0.2));
  }
}
