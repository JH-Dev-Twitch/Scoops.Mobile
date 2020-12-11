import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:scoops/ui/models/settings/app_settings_group.dart';
import 'package:scoops/ui/models/settings/display_setting.dart';
import 'package:scoops/ui/models/settings/navigation_setting.dart';
import 'package:scoops/ui/models/settings/toggle_setting.dart';
import 'package:scoops/ui/styling/custom_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSettingsModel extends BaseModel {
  List<AppSettingGroup> settingGroups;
  bool darkModeEnabled;

  Future loadPageData() async {
    setState(ViewState.Loading);
    settingGroups = new List<AppSettingGroup>();
    Future.wait([loadGeneralSettings(), loadAppInfo()]);
    setState(ViewState.Ready);
  }

  Future loadAppInfo() async {
    var group = new AppSettingGroup();
    group.groupName = "App Information";
    group.settings.add(NavigationSetting("OSS Contributions",
        Routes.OSSContributions, Icons.code_rounded, Colors.indigo));
    group.settings.add(NavigationSetting(
        "Dev Team", "dev_team", Icons.group_rounded, Colors.green));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    group.settings.add(DisplaySetting(
      "App Version",
      "v${packageInfo.version}.${packageInfo.buildNumber}",
      Icons.info_outline_rounded,
      Colors.blue,
    ));
    settingGroups.add(group);
  }

  Future rickRoll() async =>
      await launch('https://www.youtube.com/watch?v=YddwkMJG1Jo');

  void toggleDarkMode(bool value) => this.darkModeEnabled = value;

  Future loadGeneralSettings() async {
    var group = new AppSettingGroup();
    group.groupName = "General";
    group.settings = [
      ToggleSetting("Dark Mode", darkModeEnabled, CustomIcons.moon_inv,
          Colors.blueGrey, toggleDarkMode)
    ];
    settingGroups.add(group);
  }
}
