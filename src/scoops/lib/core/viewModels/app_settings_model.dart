import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:scoops/ui/styling/custom_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSettingsModel extends BaseModel {
  List<AppSettingGroup> settingGroups;
  bool darkModeEnabled = true;

  Future loadPageData() async {
    setState(ViewState.Loading);
    settingGroups = new List<AppSettingGroup>();
    await loadGeneralSettings();
    await loadAppInfo();

    setState(ViewState.Ready);
  }

  Future loadAppInfo() async {
    var group = new AppSettingGroup();
    group.groupName = "App Information";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    group.settings.add(AppSetting(
        "App Version",
        "v${packageInfo.version}.${packageInfo.buildNumber}",
        Icons.info_outline_rounded,
        Colors.blue,
        rickRoll));

    group.settings.add(AppSetting(
        "OSS Contributions", "", Icons.code_rounded, Colors.indigo, null));
    settingGroups.add(group);
  }

  Future rickRoll() async =>
      await launch('https://www.youtube.com/watch?v=YddwkMJG1Jo');

  void toggleDarkMode() => this.darkModeEnabled = !darkModeEnabled;

  Future loadGeneralSettings() async {
    var group = new AppSettingGroup();
    group.groupName = "General";
    group.settings = [
      new AppSetting("Dark Mode", darkModeEnabled.toString(),
          CustomIcons.moon_inv, Colors.blueGrey, toggleDarkMode)
    ];
    settingGroups.add(group);
  }
}

class AppSettingGroup {
  String groupName;
  List<AppSetting> settings;

  AppSettingGroup() {
    settings = new List<AppSetting>();
  }
}

class AppSetting {
  String name;
  String value;
  IconData icon;
  Color iconColor;
  Function callback;

  AppSetting(this.name, this.value, this.icon, this.iconColor, this.callback);
}
