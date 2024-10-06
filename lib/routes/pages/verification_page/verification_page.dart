import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';
import 'package:live_beer/ui/widgets/toggle_error_text.dart';

import 'package:live_beer/routes/pages/home_page/home_page.dart';
import 'package:live_beer/routes/pages/authorization_page/authorization_page.dart';
import 'package:live_beer/routes/pages/verification_page/widgets/resend_code_button.dart';
import 'package:live_beer/routes/pages/verification_page/widgets/verification_text_field.dart';

import 'package:live_beer/utils/utils.dart';

class VerificationPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController(text: '');
  final ValueNotifier<bool> isCodeIncorrectNotifier = ValueNotifier(false);

  final String number;

  final int codeLength = 4;
  final String correctCode = '1111';

  VerificationPage({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(
          color: theme.colorScheme.tertiary,
          onPressed: () => _returnToAuthorizationPage(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localizations.enterVerificationCode,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    localizations.weSentItTo,
                    style: theme.textTheme.labelSmall!
                        .apply(color: theme.colorScheme.onSecondary),
                  ),
                  Text(
                    '${localizations.numberPrefix}${number.substring(0, 11)} ** **',
                    style: theme.textTheme.labelSmall!
                        .apply(color: theme.colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            VerificationTextField(
                textController: textController,
                isCodeIncorrectNotifier: isCodeIncorrectNotifier),
            const SizedBox(height: 8),
            ToggleErrorText(
                isVisibleNotifier: isCodeIncorrectNotifier,
                text: localizations.codeIsIncorrect),
            const Spacer(),
            CustomButton(
              text: localizations.enterSystem,
              callback: () => _submitCode(context),
              isActive: () => _isButtonActive(),
              listenables: [textController],
            ),
            const SizedBox(height: 24),
            const ResendCodeButton(),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  _isButtonActive() {
    return textController.text.length == codeLength &&
        !isCodeIncorrectNotifier.value;
  }

  _submitCode(BuildContext context) async {
    isCodeIncorrectNotifier.value = false;

    String code = textController.text;

    int waitTime = Random().nextInt(2) + 1;
    await Future.delayed(Duration(seconds: waitTime));

    if (code == correctCode) {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) =>
              Utils.wrapWithTheme(context, const HomePage()),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      isCodeIncorrectNotifier.value = true;
    }
  }

  _returnToAuthorizationPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) =>
            Utils.wrapWithTheme(context, AuthorizationPage()),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
