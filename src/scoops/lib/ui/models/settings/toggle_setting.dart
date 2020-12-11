import 'package:flutter/widgets.dart';
import 'app_settings.dart';

class ToggleSetting extends AppSetting {
  bool value;
  Function(bool) onchange;
  ToggleSetting(
    String name,
    this.value,
    IconData icon,
    Color iconColor,
    this.onchange,
  ) : super(name, icon, iconColor);
}
