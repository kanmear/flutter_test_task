import 'package:flutter/material.dart';

class ToggleErrorText extends StatelessWidget {
  final String text;
  final ValueNotifier<bool> isVisibleNotifier;

  const ToggleErrorText(
      {super.key, required this.isVisibleNotifier, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder(
        valueListenable: isVisibleNotifier,
        builder: (context, isVisible, _) {
          return Text(
            isVisible ? text : '',
            style: theme.textTheme.bodySmall!
                .apply(color: theme.colorScheme.error),
          );
        });
  }
}
