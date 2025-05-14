
import 'rules/base_rule.dart';

/// Validates environment variables against the provided schema.
/// Throws an [Exception] if any validation fails.
/// If all validations pass, the app continues to run silently.
void validateEnv(
  Map<String, dynamic> config,
  Map<String, EnvRule> schema, {
  bool stripUnknown = false,
}) {
  final errors = <String>[];

  // Validate known fields
  schema.forEach((key, rule) {
    final value = config[key];
    final error = rule.validate(value, key);
    
    if (error != null) {
      errors.add(error);
    }
  });

  // Check for unknown fields
  if (!stripUnknown) {
    config.forEach((key, value) {
      if (!schema.containsKey(key)) {
        errors.add('Unknown environment variable: $key');
      }
    });
  }

  if (errors.isNotEmpty) {
    //  if (kDebugMode) {
    //   print('❌ Environment validation failed:');
    //   for (var error in errors) {
    //     print(' $error');
    //   }
    // }

     // Always throw an exception when there are validation errors
    throw Exception(
      '❌ Invalid environment configuration:\n${errors.map((e) => ' $e').join('\n')}'
    );
    
  } 
}
