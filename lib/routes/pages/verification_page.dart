import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';

import 'package:live_beer/text_data.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';
import 'package:live_beer/ui/formatters/verification_code_formatter.dart';

import 'package:live_beer/routes/pages/authorization_page.dart';

import 'package:live_beer/utils.dart';

class VerificationPage extends StatelessWidget {
  final String number;

  final int codeLength = 4;

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
            VerificationTextField(textController: textController),
            const Expanded(child: SizedBox()),
            CustomButton(
              text: TextData.enterSystem,
              callback: () => _submitCode(context),
              isActive: () => _isButtonActive(textController),
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

  _isButtonActive(TextEditingController textController) {
    return textController.text.length == codeLength;
  }

  _submitCode(BuildContext context) async {
    return true;
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

class VerificationTextField extends StatefulWidget {
  final TextEditingController textController;
  final ValueNotifier<String> codeNotifier = ValueNotifier('');

  VerificationTextField({super.key, required this.textController});

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
          ValueListenableBuilder(
            valueListenable: widget.codeNotifier,
            builder: (context, code, _) {
              return Row(children: [
                SingleInputField(value: _isInBounds(0, code) ? code[0] : null),
                const SizedBox(width: 16),
                SingleInputField(value: _isInBounds(1, code) ? code[1] : null),
                const SizedBox(width: 16),
                SingleInputField(value: _isInBounds(2, code) ? code[2] : null),
                const SizedBox(width: 16),
                SingleInputField(value: _isInBounds(3, code) ? code[3] : null),
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

  const SingleInputField({
    super.key,
    required this.value,
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
          child: Text(isValueNotNull ? value! : '●',
              style: _resolveValueStyle(theme, isValueNotNull))),
    ));
  }

  _resolveValueStyle(ThemeData theme, bool isValueNotNull) {
    return isValueNotNull
        ? theme.textTheme.titleMedium
        : theme.textTheme.bodyLarge!
            .apply(color: theme.colorScheme.onSecondary);
  }

  _resolveBorderColor(ThemeData theme, bool isValueNotNull) {
    return isValueNotNull
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.surfaceContainerLowest;
  }
}
