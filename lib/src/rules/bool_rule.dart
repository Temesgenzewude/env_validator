import 'base_rule.dart';

class BoolRule extends EnvRule<bool> {
  bool? _strictTrue;
  bool? _strictFalse;

  BoolRule();

  @override
  BoolRule required({String? message}) {
    super.required(message: message);
    return this;
  }

  @override
  BoolRule defaultValue(bool value) {
    super.defaultValue(value);
    return this;
  }

  @override
  BoolRule custom(bool Function(bool value) validator, {String? message}) {
    super.custom(validator, message: message);
    return this;
  }

  @override
  String? validateType(dynamic value, String key) {
    if (value == null) {
      return null; // Skip validation if value is null and not required
    }

    if (value is! bool) {
      // Try to convert string values
      if (value is String) {
        final lowered = value.toLowerCase();
        if (!['true', 'false', '1', '0'].contains(lowered)) {
          return '$key must be a boolean (true/false) or convertible to boolean (1/0).';
        }
      } else if (value is num) {
        if (![0, 1].contains(value)) {
          return '$key must be 0 or 1 to be converted to boolean.';
        }
      } else {
        return '$key must be a boolean value.';
      }
    }
    return null;
  }

  @override
  String? validateSpecific(bool? value, String key) {
    if (value == null) {
      return null; // Skip validation if value is null and not required
    }

    if (_strictTrue == true && !value) {
      return '$key must be true.';
    }

    if (_strictFalse == true && value) {
      return '$key must be false.';
    }

    return null;
  }

  /// Requires the value to be strictly true
  BoolRule isTrue() {
    _strictTrue = true;
    return this;
  }

  /// Requires the value to be strictly false
  BoolRule isFalse() {
    _strictFalse = true;
    return this;
  }

  /// Converts the input value to boolean
  bool? convertToBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      final lowered = value.toLowerCase();
      if (lowered == 'true' || lowered == '1') return true;
      if (lowered == 'false' || lowered == '0') return false;
    }
    if (value is num) {
      return value != 0;
    }
    return null;
  }
}
