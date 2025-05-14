import 'package:env_validator/env_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Define environment validation schema
  final Map<String, EnvRule> schema = {
    "API_URL": StringRule().required().url(),
    "DEBUG": BoolRule().required(),
    "MAX_CONNECTIONS": NumberRule().min(1).max(10).integer(),
  };

  // Validate environment variables
  await validateEnvFromFile('assets/.env', schema);

  // Load environment variables
  await dotenv.load(fileName: 'assets/.env');

  // Now you can access environment variables using dotenv
  print('API URL: ${dotenv.env['API_URL']}');
  print('Debug Mode: ${dotenv.env['DEBUG']}');
  print('Max Connections: ${dotenv.env['MAX_CONNECTIONS']}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo Home Page')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('API URL: ${dotenv.env['API_URL']}'),
              Text('Debug Mode: ${dotenv.env['DEBUG']}'),
              Text('Max Connections: ${dotenv.env['MAX_CONNECTIONS']}'),
            ],
          ),
        ),
      ),
    );
  }
}
