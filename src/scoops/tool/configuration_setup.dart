import 'app_config_builder.dart';

Future<void> main() async {
  await AppConfigBuilder(outputDir: "lib/core/infrastructure/configuration")
      .buildConfig();
}
