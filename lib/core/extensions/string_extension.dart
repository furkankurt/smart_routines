import 'dart:convert';

extension StringX on String {
  /// Converts the string to title case
  /// Example: 'hello world' -> 'Hello World'
  String get toTitleCase {
    return split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
  }

  /// Converts the string value from the database to the correct type
  /// Example: 'true' -> true, 'false' -> false, '10' -> 10
  dynamic toValue() {
    if (trim().isEmpty) return '';
    final decoded = jsonDecode(this);
    if (decoded == 'true') return true;
    if (decoded == 'false') return false;
    if (num.tryParse('$decoded') != null) return num.parse('$decoded');
    return decoded;
  }
}

/// Converts a value to a human-readable string
String namedValue(dynamic value) {
  if (value is bool) return value ? 'On' : 'Off';
  if (value is num) return (value).toString();
  if (value is String) return value;
  return '';
}
