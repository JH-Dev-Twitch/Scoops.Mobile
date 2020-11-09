import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PatrickView extends StatefulWidget {
  PatrickView({Key key}) : super(key: key);

  @override
  _JamesViewState createState() => _JamesViewState();
}

class _JamesViewState extends State<PatrickView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SafeArea(
        child: Center(child: Text('Patrick')),
      ),
    ));
  }
}
