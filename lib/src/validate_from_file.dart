import 'dart:io';
import 'package:flutter/foundation.dart';
import 'validator.dart';
import 'env_loader.dart';
import 'rules/base_rule.dart';

/// Validates environment variables from a file against the provided schema.
/// If validation fails, the app will exit immediately.
Future<void> validateEnvFromFile(
  String path,
  Map<String, EnvRule> schema, {
  bool stripUnknown = false,
}) async {
  try {
    final config = await loadEnvFile(path);
    validateEnv(config, schema, stripUnknown: stripUnknown);
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    // Exit the app with error code 1
    exit(1);
  }
}
