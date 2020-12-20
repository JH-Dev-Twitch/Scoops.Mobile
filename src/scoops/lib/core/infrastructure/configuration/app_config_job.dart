import 'dart:convert';
import 'dart:io';
import 'config_class_builder.dart';

class ConfigurationJob {
  final String configFilePath;
  final String envVariable;
  final String configClassName;
  final String outputDir;

  ConfigurationJob(
      {this.configClassName = "AppConfig",
      this.envVariable = "APP_CONFIG_JSON",
      this.configFilePath = "config.json",
      this.outputDir = "lib"});

  Future buildConfig() async {
    String data = await readConfigData();
    if (data == null) throw new Exception("No Config Data found");
    var builder = new ConfigClassBuilder(configClassName, true);
    builder.importFields(json.decode(data));
    var classData = builder.buildClass();
    var fileName = builder.generateFileNameForClass();
    await writeToEnv(fileName, classData);
  }

  Future<String> readConfigData() async => fileExists(configFilePath)
      ? await readFileContents(configFilePath)
      : readEnvVariable(envVariable);

  String readEnvVariable(String variable) =>
      Platform.environment.containsKey(variable)
          ? Platform.environment[variable]
          : null;

  Future writeToEnv(String fileName, String content) async =>
      await File('$outputDir/$fileName.dart').writeAsString(content);

  Future<String> readFileContents(String path) async =>
      await File(path).readAsString();

  bool fileExists(String path) => File(path).existsSync();
}
