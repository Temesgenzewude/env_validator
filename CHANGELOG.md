# Changelog

## 0.0.2 - Documentation and Format Updates (2025-05-15)

### Changed
- Improved README with clear asset configuration instructions for pubspec.yaml
- Fixed Dart formatting issues
- Applied consistent code formatting across the package

## 0.0.1 - Initial Release (2025-05-14)

### Added
- Base validation system with `EnvRule` class
- Type-safe validation for strings, numbers, and booleans
- Implemented `StringRule`, `NumberRule`, and `BoolRule` validators
- Chainable validation methods for building complex rules
- Smart type conversion (especially for booleans)
- Null value handling across all rule types

### Features
- String validation: length, pattern, email, URL, case transformation
- Number validation: integer/float, min/max, comparison operators
- Boolean validation: smart conversion from strings and numbers
- Flexible configuration with required fields and default values
- Detailed error messages for validation failures
- Early validation to stop app if environment is invalid
