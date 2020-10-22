import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill(
      {Key key, this.icon, this.backgroundColor, this.textColor, this.text})
      : super(key: key);
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              Text(text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  icon,
                  color: textColor,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
