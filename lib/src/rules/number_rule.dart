import 'base_rule.dart';

class NumberRule extends EnvRule<num> {
  num? _min;
  num? _max;
  num? _lessThan;
  num? _greaterThan;
  bool _integer = false;
  num? _multipleOf;
  List<num>? _allowedValues;
  bool _positive = false;
  bool _negative = false;

  NumberRule();

  @override
  NumberRule required({String? message}) {
    super.required(message: message);
    return this;
  }

  @override
  NumberRule defaultValue(num value) {
    super.defaultValue(value);
    return this;
  }

  @override
  NumberRule custom(bool Function(num value) validator, {String? message}) {
    super.custom(validator, message: message);
    return this;
  }

  @override
  String? validateType(dynamic value, String key) {
    if (value == null) {
      return null; // Skip validation if value is null and not required
    }

    if (_integer && value is! int) {
      return '$key must be an integer.';
    }
    if (value is! num) {
      return '$key must be a number.';
    }
    return null;
  }

  @override
  String? validateSpecific(num? value, String key) {
    // Skip all validations if value is null and not required
    if (value == null) {
      return null;
    }

    if (_min != null && value < _min!) {
      return '$key must be greater than or equal to $_min.';
    }

    if (_max != null && value > _max!) {
      return '$key must be less than or equal to $_max.';
    }

    if (_lessThan != null && value >= _lessThan!) {
      return '$key must be less than $_lessThan.';
    }

    if (_greaterThan != null && value <= _greaterThan!) {
      return '$key must be greater than $_greaterThan.';
    }

    if (_multipleOf != null && value % _multipleOf! != 0) {
      return '$key must be a multiple of $_multipleOf.';
    }

    if (_allowedValues != null && !_allowedValues!.contains(value)) {
      return '$key must be one of: ${_allowedValues!.join(', ')}.';
    }

    if (_positive && value <= 0) {
      return '$key must be positive.';
    }

    if (_negative && value >= 0) {
      return '$key must be negative.';
    }

    return null;
  }

  /// Sets minimum value (inclusive)
  NumberRule min(num value) {
    _min = value;
    return this;
  }

  /// Sets maximum value (inclusive)
  NumberRule max(num value) {
    _max = value;
    return this;
  }

  /// Sets a value that the number must be less than (exclusive)
  NumberRule lessThan(num value) {
    _lessThan = value;
    return this;
  }

  /// Sets a value that the number must be greater than (exclusive)
  NumberRule greaterThan(num value) {
    _greaterThan = value;
    return this;
  }

  /// Restricts to integer values
  NumberRule integer() {
    _integer = true;
    return this;
  }

  /// Requires the number to be a multiple of the given value
  NumberRule multipleOf(num value) {
    _multipleOf = value;
    return this;
  }

  /// Restricts to allowed values
  NumberRule oneOf(List<num> values) {
    _allowedValues = values;
    return this;
  }

  /// Requires the number to be positive (> 0)
  NumberRule positive() {
    _positive = true;
    return this;
  }

  /// Requires the number to be negative (< 0)
  NumberRule negative() {
    _negative = true;
    return this;
  }
}
