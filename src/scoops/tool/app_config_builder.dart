import 'dart:convert';
import 'dart:io';
import 'config_class_builder.dart';

class AppConfigBuilder {
  final String configFilePath;
  final String envVariable;
  final String configClassName;
  final String outputDir;

  AppConfigBuilder(
      {this.configClassName = "AppConfig",
      this.envVariable = "APP_CONFIG_JSON",
      this.configFilePath = "config.json",
      this.outputDir = "lib"});

  Future buildConfig() async {
    String data = await readConfigData();
    if (data == null) throw new Exception("No Config Data found");
    String formattedData = data.replaceAll(r'\"', '"');
    var builder = new ConfigClassBuilder(configClassName, true);
    Map fields = json.decode(
      formattedData,
    );
    builder.importFields(fields);
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
