import 'base_rule.dart';

class StringRule extends EnvRule<String> {
  int? _minLength;
  int? _maxLength;
  RegExp? _pattern;
  List<String>? _allowedValues;
  String? _email;
  String? _url;
  bool _trim = false;
  bool _lowercase = false;
  bool _uppercase = false;

  StringRule();

  @override
  StringRule required({String? message}) {
    super.required(message: message);
    return this;
  }

  @override
  StringRule defaultValue(String value) {
    super.defaultValue(value);
    return this;
  }

  @override
  StringRule custom(bool Function(String value) validator, {String? message}) {
    super.custom(validator, message: message);
    return this;
  }

  @override
  String? validateType(dynamic value, String key) {
    if (value != null && value is! String) {
      return '$key must be a string.';
    }
    return null;
  }

  @override
  String? validateSpecific(String value, String key) {
    String processedValue = value;
    if (_trim) processedValue = processedValue.trim();
    if (_lowercase) processedValue = processedValue.toLowerCase();
    if (_uppercase) processedValue = processedValue.toUpperCase();

    if (_minLength != null && processedValue.length < _minLength!) {
      return '$key must be at least $_minLength characters long.';
    }

    if (_maxLength != null && processedValue.length > _maxLength!) {
      return '$key must be at most $_maxLength characters long.';
    }

    if (_pattern != null && !_pattern!.hasMatch(processedValue)) {
      return '$key must match pattern ${_pattern!.pattern}.';
    }

    if (_allowedValues != null && !_allowedValues!.contains(processedValue)) {
      return '$key must be one of: ${_allowedValues!.join(', ')}.';
    }

    if (_email != null) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(processedValue)) {
        return '$key must be a valid email address.';
      }
    }

    if (_url != null) {
      try {
        final uri = Uri.parse(processedValue);
        if (!uri.isAbsolute) throw '';
      } catch (_) {
        return '$key must be a valid URL.';
      }
    }

    return null;
  }

  /// Sets minimum length requirement
  StringRule minLength(int length) {
    _minLength = length;
    return this;
  }

  /// Sets maximum length requirement
  StringRule maxLength(int length) {
    _maxLength = length;
    return this;
  }

  /// Sets exact length requirement
  StringRule length(int length) {
    _minLength = length;
    _maxLength = length;
    return this;
  }

  /// Sets a regex pattern requirement
  StringRule matches(RegExp pattern) {
    _pattern = pattern;
    return this;
  }

  /// Restricts to allowed values
  StringRule oneOf(List<String> values) {
    _allowedValues = values;
    return this;
  }

  /// Validates as email
  StringRule email() {
    _email = '';
    return this;
  }

  /// Validates as URL
  StringRule url() {
    _url = '';
    return this;
  }

  /// Trims the value before validation
  StringRule trim() {
    _trim = true;
    return this;
  }

  /// Converts to lowercase before validation
  StringRule lowercase() {
    _lowercase = true;
    return this;
  }

  /// Converts to uppercase before validation
  StringRule uppercase() {
    _uppercase = true;
    return this;
  }
}
