import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
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
              NumberTextField(textController: textController),
            ]),
            Column(children: [
              CustomButton(
                text: TextData.next,
                onTap: () => {},
                isActive: () => _isButtonActive(textController),
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
              const SizedBox(height: 24),
            ])
          ],
        ),
      ),
    );
  }

  _isButtonActive(TextEditingController controller) =>
      controller.text.length == correctNumberLength;

  _navigateToRegistration() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }
}

class NumberTextField extends StatefulWidget {
  final TextEditingController textController;

  const NumberTextField({super.key, required this.textController});

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(TextData.ruNumberPrefix,
            style: theme.textTheme.titleLarge!
                .apply(color: theme.colorScheme.onSecondary)),
        IntrinsicWidth(
          child: TextField(
            focusNode: focusNode,
            controller: widget.textController,
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
