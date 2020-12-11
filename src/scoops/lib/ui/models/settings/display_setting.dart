import 'package:flutter/widgets.dart';
import 'package:scoops/ui/models/settings/app_settings.dart';

class DisplaySetting extends AppSetting {
  String value;
  Function onPress;
  DisplaySetting(String name, this.value, IconData icon, Color iconColor,
      {this.onPress})
      : super(
          name,
          icon,
          iconColor,
        );
}
