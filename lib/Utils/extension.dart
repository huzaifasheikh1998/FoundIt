import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension IntExtension on String {
  int toInt() {
    return int.parse(this);
  }
}

extension StringExtensions on String {
  String toFormatDateTime({String format = ''}) {
    return DateFormat(format.isEmpty ? 'EEEE, d MMMM, y' : format)
        .format(DateTime.tryParse(this) ?? DateTime.now());
  }

  DateTime getFormattedDateTime({String format = ''}) {
    return DateFormat(format.isEmpty ? 'EEEE, d MMMM, y' : '')
        .parse(toFormatDateTime());
  }

  DateTime toDate() {
    return DateTime.tryParse(this) ?? DateTime.now();
  }
}

extension DateTimeExtension on DateTime {
  String toFormatDateTime({String format = ''}) {
    return DateFormat(format.isEmpty ? 'EEEE, d MMMM, y' : format).format(this);
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  }) {}

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
