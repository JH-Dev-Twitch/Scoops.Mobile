import 'package:flutter/widgets.dart';

import 'app_settings.dart';

class NavigationSetting extends AppSetting {
  String route;
  NavigationSetting(
    String name,
    this.route,
    IconData icon,
    Color iconColor,
  ) : super(name, icon, iconColor);
}
