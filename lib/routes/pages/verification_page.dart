import 'package:flutter/material.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';

class VerificationPage extends StatelessWidget {
  final String number;

  const VerificationPage({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextEditingController textController =
        TextEditingController(text: '');

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.tertiary),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(TextData.enterVerificationCode,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    TextData.weSentItTo,
                    style: theme.textTheme.labelSmall!
                        .apply(color: theme.colorScheme.onSecondary),
                  ),
                  Text(
                    '${number.substring(0, 11)} ** **',
                    style: theme.textTheme.labelSmall!
                        .apply(color: theme.colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(child: SizedBox()),
            CustomButton(
              text: TextData.enterSystem,
              callback: () => _submitNumber(context),
              isActive: () => _isButtonActive(),
              listenables: [textController],
            ),
            const SizedBox(height: 24),
            Text(TextData.canSendAgainIn,
                style: theme.textTheme.labelSmall!
                    .apply(color: theme.colorScheme.onSecondary)),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  _isButtonActive() {
    return false;
  }

  _submitNumber(BuildContext context) async {
    return true;
  }
}
