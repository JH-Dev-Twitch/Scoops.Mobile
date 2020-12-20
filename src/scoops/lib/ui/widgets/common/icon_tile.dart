import 'package:flutter/widgets.dart';

class IconTile extends StatelessWidget {
  IconTile(this.icon, this.backgroundColor, this.iconColor,
      {this.iconSize = 15});

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
