import 'dart:async';

import 'package:flutter/material.dart';

import 'package:live_beer/text_data.dart';

class ResendCodeButton extends StatefulWidget {
  const ResendCodeButton({super.key});

  @override
  ResendCodeButtonState createState() => ResendCodeButtonState();
}

class ResendCodeButtonState extends State<ResendCodeButton> {
  int counter = 59;
  Timer? countdownTimer;

  void startTimer() {
    countdownTimer?.cancel();
    setState(() {
      counter = 59;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          countdownTimer?.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFinished = counter == 0;

    if (isFinished) {
      return SizedBox(
        height: 16,
        child: GestureDetector(
          onTap: () => _resendCode(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restart_alt,
                  size: 16, color: theme.colorScheme.tertiary),
              const SizedBox(width: 4),
              Text(
                TextData.sendAgain,
                style: theme.textTheme.labelMedium!
                    .apply(color: theme.colorScheme.tertiary),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(TextData.canSendAgainIn,
                style: theme.textTheme.labelSmall!
                    .apply(color: theme.colorScheme.onSecondary)),
            Text(
              '00:${counter.toString().padLeft(2, '0')}',
              style: theme.textTheme.labelSmall,
            )
          ],
        ),
      );
    }
  }

  _resendCode() => startTimer();
}
