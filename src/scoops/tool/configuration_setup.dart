import 'package:scoops/core/infrastructure/configuration/app_config_job.dart';

Future<void> main() async {
  await ConfigurationJob(outputDir: "lib/core/infrastructure/configuration")
      .buildConfig();
}
