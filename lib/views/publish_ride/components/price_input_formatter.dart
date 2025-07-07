import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,##0.##", "en_US");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Remove commas to parse correctly
    String cleanedText = newValue.text.replaceAll(',', '');

    double? parsedValue = double.tryParse(cleanedText);
    if (parsedValue == null) return oldValue; // Keep old value if invalid

    // Format with commas (e.g., 1000 → 1,000)
    String newText = _formatter.format(parsedValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
