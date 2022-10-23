import 'package:flutter/services.dart';
import 'package:meem_app/Services/string_extension_service.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text:
          newValue.text.isNotEmpty ? newValue.text.capitalize() : newValue.text,
      selection: newValue.selection,
    );
  }
}
