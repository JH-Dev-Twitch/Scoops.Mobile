import 'package:flutter/material.dart';
import 'package:scoops/ui/views/rnd/fred.dart';
import 'package:scoops/ui/views/rnd/james.dart';
import 'package:scoops/ui/views/rnd/patrick.dart';

class RnDHomeView extends StatefulWidget {
  RnDHomeView({Key key}) : super(key: key);

  @override
  _RnDHomeViewState createState() => _RnDHomeViewState();
}

class _RnDHomeViewState extends State<RnDHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Research and Development')),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavButton(context, 'Fred', FredsView()),
            buildNavButton(context, 'Patrick', PatrickView()),
            buildNavButton(context, 'James', JamesView())
          ],
        )));
  }

  Widget buildNavButton(BuildContext context, String name, Widget view) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: RaisedButton(
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view;
            }))
          },
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                  ))),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }
}
