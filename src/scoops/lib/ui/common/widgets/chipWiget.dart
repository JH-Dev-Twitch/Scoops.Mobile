import 'package:flutter/cupertino.dart';

class Chip extends StatelessWidget {
  const Chip({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(text),
        ));
  }
}
