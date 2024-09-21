import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';
import 'package:live_beer/ui/widgets/toggle_error_text.dart';
import 'package:live_beer/ui/formatters/phone_number_formatter.dart';

import 'package:live_beer/routes/pages/verification_page.dart';

import 'package:live_beer/utils.dart';

class AuthorizationPage extends StatelessWidget {
  final int correctNumberLength = 15;
  final String registeredNumber = '1111111111';

  final TextEditingController textController = TextEditingController(text: '');
  final ValueNotifier<String> failedNumberNotifier = ValueNotifier('');
  final ValueNotifier<bool> isNotFoundNotifier = ValueNotifier(false);

  AuthorizationPage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(TextData.enterYourPhoneNumber,
                style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                TextData.weWillSendYouVerificationCode,
                style: theme.textTheme.labelSmall!
                    .apply(color: theme.colorScheme.onSecondary),
              ),
            ),
            const SizedBox(height: 16),
            NumberTextField(
              textController: textController,
              isNotFoundNotifier: isNotFoundNotifier,
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: ToggleErrorText(
                text: TextData.thatNumberIsNotRegistered,
                isVisibleNotifier: isNotFoundNotifier,
              ),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
              text: TextData.next,
              callback: () => _submitNumber(context),
              isActive: () => _isButtonActive(),
              listenables: [textController],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(TextData.doNotHaveAnAccount,
                    style: theme.textTheme.labelMedium),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _navigateToRegistration(),
                  child: Text(TextData.registration,
                      style: theme.textTheme.labelMedium!
                          .apply(color: theme.colorScheme.tertiary)),
                ),
              ],
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  _isButtonActive() {
    return textController.text.length == correctNumberLength &&
        textController.text != failedNumberNotifier.value;
  }

  _submitNumber(BuildContext context) async {
    isNotFoundNotifier.value = false;

    String number = textController.text;

    int waitTime = Random().nextInt(4) + 1;
    await Future.delayed(Duration(seconds: waitTime));

    if (number.replaceAll(RegExp(r'[ ()]'), '') == registeredNumber) {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => Utils.wrapWithTheme(
              context,
              VerificationPage(
                number: number,
              )),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      failedNumberNotifier.value = number;
      isNotFoundNotifier.value = true;
    }
  }

  _navigateToRegistration() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }
}

class NumberTextField extends StatefulWidget {
  final TextEditingController textController;
  final ValueNotifier<bool> isNotFoundNotifier;

  const NumberTextField({
    super.key,
    required this.textController,
    required this.isNotFoundNotifier,
  });

  @override
  State<NumberTextField> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //this guarantees text field gets focused
      Timer(const Duration(milliseconds: 500), () => focusNode.requestFocus());
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: widget.isNotFoundNotifier,
      builder: (context, isNotFound, _) {
        return Row(
          children: [
            Text(TextData.ruNumberPrefix,
                style: theme.textTheme.titleLarge!
                    .apply(color: _resolvePrefixColor(theme))),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: widget.textController,
                inputFormatters: [
                  PhoneNumberFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(r'[() 0-9]'))
                ],
                keyboardType: TextInputType.number,
                cursorColor: theme.colorScheme.onPrimary,
                style: theme.textTheme.titleLarge!
                    .apply(color: _resolveNumberColor(theme)),
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
      },
    );
  }

  _resolvePrefixColor(ThemeData theme) {
    return (widget.isNotFoundNotifier.value)
        ? theme.colorScheme.error
        : theme.colorScheme.onSecondary;
  }

  _resolveNumberColor(ThemeData theme) {
    return (widget.isNotFoundNotifier.value)
        ? theme.colorScheme.error
        : theme.colorScheme.onPrimary;
  }
}
