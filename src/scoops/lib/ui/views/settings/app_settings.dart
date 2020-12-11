import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/core/viewModels/app_settings_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/icon_tile.dart';
import 'package:scoops/ui/widgets/common/plain_app_bar.dart';

class AppSettingsView extends StatelessWidget {
  AppSettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppSettingsModel>(
      onModelReady: (model) async => await model.loadPageData(),
      builder: (context, model, child) => Scaffold(
        appBar: PlainAppBar.buildAppBar(context, title: 'Settings'),
        body: SingleChildScrollView(
          child: model.state == ViewState.Loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                )
              : SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [buildGroups(context, model.settingGroups)],
                  ),
                )),
        ),
      ),
    );
  }

  Column buildGroups(BuildContext context, List<AppSettingGroup> groups) {
    var cols = new List<Column>();
    for (var group in groups) {
      var col = buildSettingGroup(context, group);
      cols.add(col);
    }
    return Column(children: cols);
  }

  Column buildGroupSettings(BuildContext context, List<AppSetting> properties) {
    var items = new List<Widget>();
    for (var setting in properties) {
      switch (setting.name) {
        case 'App Version':
          {
            items.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: buildAppVersion(context, setting),
            ));
            break;
          }
        case 'Dark Mode':
          {
            items.add(buildDarkModeSwitch(setting));
            break;
          }
        case 'OSS Contributions':
          {
            items.add(buildOSSSection(context, setting));
            break;
          }
        default:
          items.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconTile(
                    setting.icon,
                    setting.iconColor,
                    Colors.white,
                  ),
                ),
                Text(setting.name),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(setting.value ?? "loading..."),
                ),
              ],
            ),
          ));
          break;
      }
    }
    return Column(children: items);
  }

  Widget buildAppVersion(BuildContext context, AppSetting setting) {
    return GestureDetector(
        onLongPress: () =>
            userConfirmation(context, () async => await setting.callback()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconTile(Icons.info_outline_rounded,
                  AppStyles.primaryTheme.primaryColor, Colors.white),
            ),
            Text(setting.name),
            Spacer(),
            Text(setting.value ?? "loading..."),
          ],
        ));
  }

  Column buildSettingGroup(BuildContext context, AppSettingGroup group) =>
      Column(
        children: [
          buildGroupHeader(group.groupName),
          buildGroupSettings(context, group.settings)
        ],
      );

  Future<void> userConfirmation(BuildContext context, Function callback) async {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Gain Root access?'),
              content: Text(
                  '''Are you sure you want to enable god mode?\nNot everyone can wield this power!'''),
              actions: [
                TextButton(
                  child: Text("I'm not worthy"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: Text("My word is Iron"),
                    onPressed: () async => await callback())
              ],
            ));
  }

  Widget buildGroupHeader(String groupName) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              groupName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildDarkModeSwitch(AppSetting setting) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconTile(setting.icon, setting.iconColor, Colors.white),
          ),
          Text(setting.name),
          Spacer(),
          Switch(
              value: setting.value == "true",
              onChanged: (value) => setting.callback()),
        ],
      );

  Widget buildOSSSection(BuildContext context, AppSetting setting) =>
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.OSSContributions),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconTile(setting.icon, setting.iconColor, Colors.white),
            ),
            Text(setting.name),
            Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.black,
            ),
          ],
        ),
      );
}
