import 'package:flutter/material.dart';
import 'package:ishop/app/home/home_view.dart';
import 'package:ishop/app/login/login_view.dart';
import 'package:ishop/app/places/places_view.dart';
import 'package:ishop/dev/dev.dart';

class RouteArguments {
  RouteArguments({this.isAuthorized = false});
  bool isAuthorized;
}

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name != 'login') {
      final isAuthorized = settings.arguments != null
          ? (settings.arguments as RouteArguments).isAuthorized
          : false;
      if (!isAuthorized) {
        settings = RouteSettings(name: 'login');
      }
    }
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'places':
        return MaterialPageRoute(builder: (_) => PlacesView());
      case 'dev':
        return MaterialPageRoute(builder: (_) => Dev());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
