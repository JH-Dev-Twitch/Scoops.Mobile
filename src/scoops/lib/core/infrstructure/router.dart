import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/ui/views/home.dart';
import 'package:scoops/ui/views/login/login.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());

      case 'home':
        return MaterialPageRoute(builder: (_) => ScoopsHomePage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('Routing Error'),
                )));
    }
  }
}
