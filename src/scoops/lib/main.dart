import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:provider/provider.dart';
import 'package:scoops/core/constants/app_constants.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/infrastructure/Routing/router.dart';
import 'package:scoops/core/infrastructure/configuration/app_config.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/core/services/authentication_service.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:flutter/foundation.dart';

Future initAppCenter() async {
  await AppCenter.startAsync(
    appSecretAndroid: AppConfig().appCenterConfig.platformIdentifiers.androidId,
    enableDistribute: AppConfig().appCenterConfig.enableDistribution,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppCenter();
  initializeServiceLocator();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var service = locator<AuthenticationService>();
    var user = service.getCurrentUser();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppStyles
            .primaryTheme.primaryColor //or set color with: Color(0xFF0000FF)
        ));
    return StreamProvider(
        initialData: user,
        create: (BuildContext context) =>
            locator<AuthenticationService>().userController.stream,
        child: MaterialApp(
          title: AppConstants.app_name,
          debugShowCheckedModeBanner: false,
          theme: AppStyles.primaryTheme,
          initialRoute: Routes.LoginView,
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _message =
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
                color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 20),
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
