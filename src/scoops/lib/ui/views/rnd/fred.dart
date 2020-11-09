import 'package:flutter/material.dart';

class FredsView extends StatefulWidget {
  FredsView({Key key}) : super(key: key);

  @override
  _FredsViewState createState() => _FredsViewState();
}

class _FredsViewState extends State<FredsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Text('Fred'),
        ),
      ),
    );
  }
}
