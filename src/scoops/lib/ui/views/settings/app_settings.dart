import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/viewModels/app_settings_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
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
        appBar: PlainAppBar.buildAppBar(context, title: 'App Settings'),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onLongPress: () => userConfirmation(
                      context, () async => await model.rickRoll()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.info_rounded,
                          color: AppStyles.primaryTheme.primaryColor,
                        ),
                      ),
                      Text('App Version'),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(model.appVersion ?? "loading..."),
                      ),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }

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
}
