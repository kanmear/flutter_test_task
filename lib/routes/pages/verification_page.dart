import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';
import 'package:live_beer/ui/widgets/toggle_error_text.dart';
import 'package:live_beer/ui/formatters/verification_code_formatter.dart';

import 'package:live_beer/routes/pages/home_page.dart';
import 'package:live_beer/routes/pages/authorization_page.dart';

import 'package:live_beer/utils.dart';

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
                    '+7 ${number.substring(0, 11)} ** **',
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
                text: TextData.codeIsIncorrect),
            const Expanded(child: SizedBox()),
            CustomButton(
              text: TextData.enterSystem,
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

class VerificationTextField extends StatefulWidget {
  final ValueNotifier<bool> isCodeIncorrectNotifier;
  final TextEditingController textController;

  final ValueNotifier<String> codeNotifier = ValueNotifier('');

  VerificationTextField({
    super.key,
    required this.textController,
    required this.isCodeIncorrectNotifier,
  });

  @override
  State<VerificationTextField> createState() => _VerificationTextFieldState();
}

class _VerificationTextFieldState extends State<VerificationTextField> {
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

    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          TextField(
            focusNode: focusNode,
            controller: widget.textController,
            onChanged: (value) => _updateValueNotifier(value),
            onSubmitted: (value) => focusNode.requestFocus(),
            keyboardType: TextInputType.number,
            cursorColor: Colors.transparent,
            style: theme.textTheme.bodyLarge!.apply(color: Colors.transparent),
            inputFormatters: [
              VerificationCodeFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              widget.codeNotifier,
              widget.isCodeIncorrectNotifier,
            ]),
            builder: (context, _) {
              final code = widget.codeNotifier.value;
              final isCorrect = !widget.isCodeIncorrectNotifier.value;

              return Row(children: [
                SingleInputField(
                    value: _isInBounds(0, code) ? code[0] : null,
                    isCorrect: isCorrect),
                const SizedBox(width: 16),
                SingleInputField(
                    value: _isInBounds(1, code) ? code[1] : null,
                    isCorrect: isCorrect),
                const SizedBox(width: 16),
                SingleInputField(
                    value: _isInBounds(2, code) ? code[2] : null,
                    isCorrect: isCorrect),
                const SizedBox(width: 16),
                SingleInputField(
                    value: _isInBounds(3, code) ? code[3] : null,
                    isCorrect: isCorrect),
              ]);
            },
          ),
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _refocusTextField(),
              ))
        ],
      ),
    );
  }

  _updateValueNotifier(String value) {
    widget.codeNotifier.value = value;
    widget.isCodeIncorrectNotifier.value = false;
  }

  _isInBounds(int index, String string) {
    return (index >= 0) && (index < string.length);
  }

  _refocusTextField() {
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 50), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }
}

class SingleInputField extends StatelessWidget {
  final String? value;
  final bool isCorrect;

  const SingleInputField({
    super.key,
    required this.value,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isValueNotNull = value != null;

    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: _resolveBorderColor(theme, isValueNotNull),
      ))),
      child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            style: _resolveValueStyle(theme, isValueNotNull),
            child: Text(isValueNotNull ? value! : '●'),
          )),
    ));
  }

  _resolveValueStyle(ThemeData theme, bool isValueNotNull) {
    if (!isCorrect) {
      return theme.textTheme.titleMedium!.apply(color: theme.colorScheme.error);
    }

    return isValueNotNull
        ? theme.textTheme.titleMedium
        : theme.textTheme.bodyLarge!
            .apply(color: theme.colorScheme.onSecondary);
  }

  _resolveBorderColor(ThemeData theme, bool isValueNotNull) {
    if (!isCorrect) {
      return theme.colorScheme.error;
    }

    return isValueNotNull
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.surfaceContainerLowest;
  }
}
