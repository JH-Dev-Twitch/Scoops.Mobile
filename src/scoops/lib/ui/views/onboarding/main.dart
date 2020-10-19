import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoops/ui/views/home.dart';
import 'package:scoops/ui/views/onboarding/fred.dart';
import 'package:scoops/ui/views/onboarding/james.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            new Color(0xff166FFF) //or set color with: Color(0xFF0000FF)
        ));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      "A platform built to help degenerates like Fred and James rate pints.";

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
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return FredsView();
                      }))
                    },
                    color: _primary,
                    textColor: Colors.white,
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Fred',
                              style: TextStyle(fontSize: 20),
                            ))),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.push(context,
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
                              'John',
                              style: TextStyle(fontSize: 20),
                            ))),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return JamesView();
                      }))
                    },
                    color: _primary,
                    textColor: Colors.white,
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'James',
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
