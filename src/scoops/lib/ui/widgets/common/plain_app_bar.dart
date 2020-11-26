import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlainAppBar {
  PlainAppBar(this.title, {this.icon = Icons.close_rounded});

  final String title;
  final IconData icon;
  static AppBar buildAppBar(BuildContext context,
      {final String title, final IconData icon = Icons.close_rounded}) {
    return AppBar(
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(title),
      leading: GestureDetector(
        child: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
