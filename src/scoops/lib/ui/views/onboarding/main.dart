import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoops/core/constants/app_constants.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/infrastructure/Routing/router.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/ui/views/home.dart';
import 'package:scoops/ui/views/login/login.dart';
import 'package:scoops/ui/views/onboarding/fred.dart';
import 'package:scoops/ui/views/onboarding/james.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeServiceLocator();
  await Firebase.initializeApp();
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
      title: AppConstants.app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.LoginView,
      onGenerateRoute: AppRouter.generateRoute,
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
                    padding: const EdgeInsets.all(25),
                    child: Icon(
                      Icons.local_drink_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
                Center(
                    child: Text(
                  AppConstants.app_name,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                )),
                Center(
                    child: Text(
                  'For pissheads, by pissheads',
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ))
              ],
            ),
          )),
          Container(
            color: Colors.white,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    'Welcome to Scoops',
                    style: TextStyle(
                        color: _primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _secondary, fontSize: 20),
                  )),
              buildNavButton(context, 'Fred', FredsView()),
              buildNavButton(context, 'John', LoginView()),
              buildNavButton(context, 'James', JamesView())
            ]),
          ),
        ],
      ),
    );
  }

  Padding buildNavButton(BuildContext context, String name, Widget view) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: RaisedButton(
          onPressed: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return view;
            }))
          },
          color: _primary,
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
