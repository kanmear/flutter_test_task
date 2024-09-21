import 'package:flutter/material.dart';

import 'package:live_beer/ui/widgets/loading_indicator.dart';

class CustomButton extends StatefulWidget {
  final List<Listenable> listenables;
  final Function isActive;
  final Function callback;
  final String text;

  const CustomButton({
    super.key,
    required this.text,
    required this.callback,
    required this.isActive,
    required this.listenables,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge(widget.listenables),
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
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: Center(
                  child: isLoading
                      ? const LoadingIndicator()
                      : Text(
                          widget.text,
                          style: _resolveStyle(theme),
                          textAlign: TextAlign.center,
                        ),
                ),
              ));
        });
  }

  _resolveAction() => widget.isActive() ? _onTap() : {};

  _onTap() async {
    setState(() {
      isLoading = true;
    });

    await widget.callback();

    setState(() {
      isLoading = false;
    });
  }

  _resolveOverlayColor() =>
      widget.isActive() && !isLoading ? Colors.black : Colors.transparent;

  _resolveColor(ThemeData theme) => widget.isActive()
      ? theme.colorScheme.primary
      : theme.colorScheme.secondary;

  _resolveStyle(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;

    return widget.isActive()
        ? theme.textTheme.bodyLarge!.apply(color: color)
        : theme.textTheme.bodyLarge!.apply(color: color.withOpacity(0.2));
  }
}
