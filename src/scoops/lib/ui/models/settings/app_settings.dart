import 'package:flutter/widgets.dart';

abstract class AppSetting {
  String name;
  IconData icon;
  Color iconColor;
  // Function callback;

  AppSetting(this.name, this.icon, this.iconColor);
}
