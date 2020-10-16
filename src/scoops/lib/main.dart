import 'package:flutter/material.dart';
import 'package:scoops/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _primary = new Color(0xff166FFF);
  Color _secondary = new Color(0xff9FBFF4);
  String _message =
      "A platform built to help digenerates like Fred and James rate pints.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: _primary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      Icons.local_drink_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
                Center(
                    child: Text(
                  'Scoops',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                )),
                Center(
                    child: Text(
                  'For pissheads, by pissheads',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ))
              ],
            ),
          )),
          Container(
            color: Colors.white,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Text(
                    'Welcome to Scoops',
                    style: TextStyle(
                        color: _primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 60),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _secondary, fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 50),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ScoopsHomePage();
                      }))
                    },
                    color: _primary,
                    textColor: Colors.white,
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 20),
                            ))),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
