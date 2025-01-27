import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits

    String formattedText;
    if (text.length > 10) {
      formattedText = '(${text.substring(0, 3)}) ${text.substring(3, 6)}-${text.substring(6, 10)}';
    } else if (text.length > 6) {
      formattedText = '(${text.substring(0, 3)}) ${text.substring(3, 6)}-${text.substring(6)}';
    } else if (text.length > 3) {
      formattedText = '(${text.substring(0, 3)}) ${text.substring(3)}';
    } else {
      formattedText = text;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
