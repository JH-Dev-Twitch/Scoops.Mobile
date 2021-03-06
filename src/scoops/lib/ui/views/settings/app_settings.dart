import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/settings/app_settings_model.dart';
import 'package:scoops/ui/models/settings/app_settings.dart';
import 'package:scoops/ui/models/settings/app_settings_group.dart';
import 'package:scoops/ui/models/settings/display_setting.dart';
import 'package:scoops/ui/models/settings/navigation_setting.dart';
import 'package:scoops/ui/models/settings/toggle_setting.dart';
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
      Widget child;
      switch (setting.runtimeType) {
        case ToggleSetting:
          {
            child = buildToggleSetting(setting);
            break;
          }
        case NavigationSetting:
          {
            child = buildNavigationSetting(context, setting);
            break;
          }
        default:
          child = buildBasicSetting(context, setting);
          break;
      }
      items.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: child,
      ));
    }
    return Column(children: items);
  }

  Widget buildBasicSetting(BuildContext context, DisplaySetting setting) {
    var child = Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(setting.value ?? "loading..."));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildSettingIconAndLabel(setting),
        Spacer(),
        setting.name == 'App Version'
            ? GestureDetector(
                onLongPress: () => userConfirmation(
                    context, () async => await setting.onPress()),
                child: child,
              )
            : child
      ],
    );
  }

  Column buildSettingGroup(BuildContext context, AppSettingGroup group) =>
      Column(
        children: [
          buildGroupHeader(group.groupName),
          buildGroupSettings(context, group.settings)
        ],
      );

  Row buildSettingIconAndLabel(AppSetting setting) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconTile(setting.icon, setting.iconColor, Colors.white,
                iconSize: 18),
          ),
          Text(setting.name),
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
                    child: Text("Give me God mode"),
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

  Widget buildToggleSetting(ToggleSetting setting) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSettingIconAndLabel(setting),
          Spacer(),
          Switch(value: setting.value == true, onChanged: setting.onchange),
        ],
      );

  Widget buildNavigationSetting(
          BuildContext context, NavigationSetting setting) =>
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, setting.route),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildSettingIconAndLabel(setting),
            Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.black,
            ),
          ],
        ),
      );
}
