import 'package:package_info/package_info.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSettingsModel extends BaseModel {
  String appVersion;

  Future loadPageData() async {
    setState(ViewState.Loading);
    await Future.wait([loadAppInfo()]);
    setState(ViewState.Ready);
  }

  Future loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}.${packageInfo.buildNumber}";
  }

  Future rickRoll() async =>
      await launch('https://www.youtube.com/watch?v=YddwkMJG1Jo');
}
