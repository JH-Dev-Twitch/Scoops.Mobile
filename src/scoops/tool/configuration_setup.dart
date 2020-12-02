import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  Map<String, String> envVars = Platform.environment;
  final Map<String, String> configuration = {
    'APP_CENTER_ANDROID_SECRET': envVars["APP_CENTER_ANDROID_SECRET"]
  };
  var config = json.encode(configuration);

  File('lib/core/infrastructure/env.dart')
      .writeAsString('final Map<String, String> env = ${config};');
}
