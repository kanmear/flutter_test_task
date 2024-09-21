import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:live_beer/ui/formatters/regex/regex_utils.dart';

import 'package:live_beer/ui/formatters/verification_code_formatter.dart';

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
              FilteringTextInputFormatter.allow(RegexUtils.digitsOnly),
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
