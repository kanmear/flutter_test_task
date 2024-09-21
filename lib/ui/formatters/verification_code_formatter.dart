import 'package:flutter/services.dart';

class VerificationCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldText = oldValue.text;
    final newText = newValue.text;

    // limit input
    if (newText.length > 4) {
      return newValue.copyWith(
          text: oldText,
          selection: TextSelection.collapsed(offset: oldText.length));
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
