import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/ui/views/home.dart';
import 'package:scoops/ui/views/login/login.dart';
import 'package:scoops/ui/views/search/search.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.LoginView:
        return MaterialPageRoute(builder: (_) => LoginView());

      case Routes.HomeView:
        return MaterialPageRoute(builder: (_) => ScoopsHomePage());

      case Routes.SearchView:
        return MaterialPageRoute(builder: (_) => SearchView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('Routing Error'),
                )));
    }
  }
}
