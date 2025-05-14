import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadEnvFile(String path) async {
  try {
    final raw = await rootBundle.loadString(path);
    final Map<String, dynamic> env = {};
    final lines = raw.split('\n');

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;

      final index = line.indexOf('=');
      if (index == -1) continue;

      final key = line.substring(0, index).trim();
      final value = line.substring(index + 1).trim();

      env[key] = _parseValue(value);
    }

    return env;
  } catch (e) {
    throw Exception(
      'Failed to load .env file: $path\n'
      'Make sure the file exists in your assets folder and is properly declared in pubspec.yaml',
    );
  }
}

dynamic _parseValue(String value) {
  if (value.toLowerCase() == 'true') return true;
  if (value.toLowerCase() == 'false') return false;
  if (num.tryParse(value) != null) return num.parse(value);
  return value;
}
