<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# env_validator

A robust Flutter package for validating environment variables with a fluent, type-safe API inspired by Joi. Ensure your environment configuration is correct before your app starts running.

[![pub package](https://img.shields.io/pub/v/env_validator.svg)](https://pub.dev/packages/env_validator)
[![likes](https://img.shields.io/pub/likes/env_validator)](https://pub.dev/packages/env_validator/score)
[![popularity](https://img.shields.io/pub/popularity/env_validator)](https://pub.dev/packages/env_validator/score)
[![style: flutter_lints](https://img.shields.io/badge/style-flutter_lints-blue)](https://pub.dev/packages/flutter_lints)

## Features

- 🔒 **Type-safe validation** for strings, numbers, and booleans
- 🔗 **Chainable API** for building complex validation rules
- 🎯 **Smart type conversion** for boolean and number values
- ⚡ **Early validation** - stops app if environment is invalid
- 📝 **Detailed error messages** for validation failures
- 🎨 **Flexible configuration** with required fields and default values
- 🔄 **Works with any .env loader** (includes built-in asset loading)

### Validation Rules

#### String Validation
- Required/optional fields
- Min/max length
- Pattern matching (regex)
- Email validation
- URL validation
- Case transformation (upper/lower)
- Trimming
- Allowed values list
- Custom validators

#### Number Validation
- Integer/float validation
- Min/max values
- Less than/greater than
- Positive/negative checks
- Multiple of validation
- Allowed values list
- Custom validators

#### Boolean Validation
- Smart conversion from strings ('true'/'false'/'1'/'0')
- Smart conversion from numbers (0/1)
- Strict true/false validation
- Custom validators

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  env_validator: ^0.0.1
```

## Usage

### Basic Example

```dart
void main() async {
  // Define your validation schema
  final schema = {
    "API_URL": StringRule()
      .required()
      .url(),
    "DEBUG": BoolRule()
      .required()
      .defaultValue(true),
    "MAX_CONNECTIONS": NumberRule()
      .required()
      .integer()
      .min(1)
      .max(10),
  };

  // Validate environment variables
  await validateEnvFromFile('assets/.env', schema);
  
  // If validation passes, your app continues
  runApp(const MyApp());
}
```

### Validation Rules Examples

#### String Validation
```dart
"EMAIL": StringRule()
  .required()
  .email()
  .lowercase(),

"API_KEY": StringRule()
  .required()
  .minLength(32)
  .matches(RegExp(r'^[A-Za-z0-9-_]+$')),

"LOG_LEVEL": StringRule()
  .oneOf(['debug', 'info', 'warn', 'error'])
  .defaultValue('info'),
```

#### Number Validation
```dart
"PORT": NumberRule()
  .required()
  .integer()
  .min(1000)
  .max(9999)
  .defaultValue(3000),

"TIMEOUT": NumberRule()
  .positive()
  .lessThan(60),

"SCALE_FACTOR": NumberRule()
  .required()
  .multipleOf(0.5)
  .min(0.5)
  .max(2.0),
```

#### Boolean Validation
```dart
"FEATURE_FLAG": BoolRule()
  .defaultValue(false),

"STRICT_MODE": BoolRule()
  .required()
  .isTrue(),

"MAINTENANCE_MODE": BoolRule()
  .required()
  .isFalse(),
```

### Using with flutter_dotenv

The package works great with `flutter_dotenv`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // First validate environment
  await validateEnvFromFile('assets/.env', schema);
  
  // Then load with dotenv
  await dotenv.load(fileName: 'assets/.env');
  
  // Access your validated environment variables
  final apiUrl = dotenv.env['API_URL']!; // Safe to use ! after validation
}
```

## Error Messages

The package provides clear, actionable error messages:

```
❌ Environment validation failed:
  - API_URL must be a valid URL.
  - MAX_CONNECTIONS must be greater than or equal to 1.
  - DEBUG must be a boolean (true/false) or convertible to boolean (1/0).
```

## Additional Information

### File Location
Place your `.env` file:
- In your assets folder

### Contributing
Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Support
- 📚 [Documentation](https://pub.dev/documentation/env_validator/latest/)
- 🐛 [Issue Tracker](https://github.com/Temesgenzewude/env_validator/issues)
- 💬 [Discussions](https://github.com/Temesgenzewude/env_validator/discussions)
