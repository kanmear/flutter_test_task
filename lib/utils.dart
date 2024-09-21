import 'package:flutter/material.dart';

class Utils {
  static Widget wrapWithTheme(BuildContext context, Widget widget) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onPrimary;

    return Theme(
        data: theme.copyWith(
            textTheme: theme.textTheme
                .apply(bodyColor: textColor, displayColor: textColor)),
        child: widget);
  }
}
