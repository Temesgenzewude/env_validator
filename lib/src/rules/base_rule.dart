abstract class EnvRule<T> {
  bool _required = false;
  String? _customMessage;
  dynamic _defaultValue;
  final List<Function(T)> _customValidators = [];

  /// Validates the value against all rules
  String? validate(dynamic value, String key) {
    // Handle required check
    if (value == null || (value is String && value.isEmpty)) {
      if (_required) {
        return _customMessage ?? '$key is required.';
      }
      if (_defaultValue != null) {
        value = _defaultValue;
      } else {
        return null; // Skip validation for null optional values
      }
    }

    // Type validation and specific rule validation
    final typeError = validateType(value, key);
    if (typeError != null) return typeError;

    // Run specific validation rules
    final T typedValue = value as T;
    final specificError = validateSpecific(typedValue, key);
    if (specificError != null) return specificError;

    // Run custom validators
    for (var validator in _customValidators) {
      try {
        validator(typedValue);
      } catch (e) {
        return e.toString();
      }
    }

    return null;
  }

  /// Type-specific validation to be implemented by subclasses
  String? validateType(dynamic value, String key);

  /// Specific validation rules to be implemented by subclasses
  String? validateSpecific(T value, String key) => null;

  /// Makes the field required
  EnvRule<T> required({String? message}) {
    _required = true;
    _customMessage = message;
    return this;
  }

  /// Sets a default value
  EnvRule<T> defaultValue(T value) {
    _defaultValue = value;
    return this;
  }

  /// Adds a custom validator function
  EnvRule<T> custom(bool Function(T value) validator, {String? message}) {
    _customValidators.add((value) {
      if (!validator(value)) {
        throw message ?? 'Custom validation failed';
      }
    });
    return this;
  }

  /// Gets the default value if set
  T? getDefaultValue() => _defaultValue as T?;
}
