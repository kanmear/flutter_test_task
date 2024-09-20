import 'package:flutter/material.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';

import 'package:live_beer/text_data.dart';

class AuthorizationPage extends StatelessWidget {
  final int correctNumberLength = 15;

  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextEditingController textController =
        TextEditingController(text: '(913) 210 95 82');

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
            NumberTextField(textController: textController),
            const SizedBox(height: 48),
            CustomButton(
              text: TextData.next,
              onTap: () => {},
              isActive: () => _isButtonActive(textController),
              listenables: [textController],
            )
          ],
        ),
      ),
    );
  }

  _isButtonActive(TextEditingController controller) =>
      controller.text.length == correctNumberLength;
}

class NumberTextField extends StatelessWidget {
  final TextEditingController textController;

  const NumberTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(TextData.ruNumberPrefix,
            style: theme.textTheme.titleLarge!
                .apply(color: theme.colorScheme.onSecondary)),
        IntrinsicWidth(
          child: TextField(
            controller: textController,
            //FIX autofocus not opening keyboard / showing cursor
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
