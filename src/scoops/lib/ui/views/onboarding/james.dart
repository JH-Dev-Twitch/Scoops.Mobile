import 'package:flutter/material.dart';

class JamesView extends StatefulWidget {
  JamesView({Key key}) : super(key: key);

  @override
  _JamesViewState createState() => _JamesViewState();
}

class _JamesViewState extends State<JamesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SafeArea(
        child: Text('James'),
      ),
    ));
  }
}
