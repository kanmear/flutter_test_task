class RegexUtils {
  static RegExp spacesLiteralParentheses = RegExp(r'[ ()]');
  static RegExp numbersSpacesLiteralParentheses = RegExp(r'[() 0-9]');
  static RegExp digitsOnly = RegExp(r'[0-9]');
  static RegExp nonDigits = RegExp(r'\D');
}
