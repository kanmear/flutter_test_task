import 'package:flutter/services.dart';
import 'package:live_beer/ui/formatters/regex/regex_utils.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldText = oldValue.text;
    final newText = newValue.text;

    // limit input
    if (newText.length > 15) {
      return newValue.copyWith(
          text: oldText,
          selection: TextSelection.collapsed(offset: oldText.length));
    }

    // allow removing values in parentheses
    String phoneNumber = newText;
    if (newText.length == 4 && oldText.length == 5) {
      phoneNumber = newText.substring(0, 3);
    }

    phoneNumber = phoneNumber.replaceAll(RegexUtils.nonDigits, '');
    final match =
        RegExp(r'^(\d{3})(\d{0,3})(\d{0,2})(\d{0,2})$').firstMatch(phoneNumber);

    // format number
    if (match != null) {
      phoneNumber = '(${match.group(1)})'
          '${match.group(2)!.isNotEmpty ? ' ' : ''}${match.group(2)!}'
          '${match.group(3)!.isNotEmpty ? ' ' : ''}${match.group(3)!}'
          '${match.group(4)!.isNotEmpty ? ' ' : ''}${match.group(4)!}';
    }

    return newValue.copyWith(
        text: phoneNumber,
        selection: TextSelection.collapsed(offset: phoneNumber.length));
  }
}
