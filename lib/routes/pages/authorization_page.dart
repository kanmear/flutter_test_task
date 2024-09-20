import 'package:flutter/material.dart';

import 'package:live_beer/text_data.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.tertiary),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(TextData.enterYourPhoneNumber,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              TextData.weWillSendYouVerificationCode,
              style: theme.textTheme.labelSmall!
                  .apply(color: theme.colorScheme.onSecondary),
            ),
            const SizedBox(height: 16),
            const NumberTextField(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  const NumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextEditingController textController =
        TextEditingController(text: '(913) 210 95 82');

    return Row(
      children: [
        Text(TextData.RuNumberPrefix,
            style: theme.textTheme.titleLarge!
                .apply(color: theme.colorScheme.onSecondary)),
        IntrinsicWidth(
          child: TextField(
            controller: textController,
            autofocus: true,
            keyboardType: TextInputType.number,
            cursorColor: theme.colorScheme.onPrimary,
            style: theme.textTheme.titleLarge,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
