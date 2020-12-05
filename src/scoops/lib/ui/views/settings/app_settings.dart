import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/app_settings_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/icon_tile.dart';
import 'package:scoops/ui/widgets/common/plain_app_bar.dart';

class AppSettingsView extends StatefulWidget {
  AppSettingsView({Key key}) : super(key: key);

  @override
  _AppSettingsViewState createState() => _AppSettingsViewState();
}

class _AppSettingsViewState extends State<AppSettingsView> {
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
                    children: [
                      // buildGroupHeader("App Theme"),
                      // insertDividers(Row(
                      //   children: [
                      //     Text('Dark Mode'),
                      //     Spacer(),
                      //     Switch(
                      //         value: model.darkModeEnabled ?? false,
                      //         onChanged: (bool) => {}),
                      //   ],
                      // )),
                      buildGroups(model.settingGroups)
                    ],
                  ),
                )),
        ),
      ),
    );
  }

  Column buildGroups(List<AppSettingGroup> groups) {
    var cols = new List<Column>();
    for (var group in groups) {
      var col = buildSettingGroup(group);
      cols.add(col);
    }
    return Column(children: cols);
  }

  Column buildGroupSettings(List<AppSetting> properties) {
    var items = new List<Widget>();
    for (var setting in properties) {
      if (setting.name == 'App Version') {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: buildAppVersion(context, setting),
        ));
      } else if (setting.name == 'Dark Mode') {
        items.add(buildDarkModeSwitch(setting));
      } else {
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
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(setting.value ?? "loading..."),
            ),
          ],
        ));
  }

  Column buildSettingGroup(AppSettingGroup group) => Column(
        children: [
          buildGroupHeader(group.groupName),
          buildGroupSettings(group.settings)
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
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Switch(
                value: setting.value == "true",
                onChanged: (value) => setting.callback()),
          ),
        ],
      );
}
