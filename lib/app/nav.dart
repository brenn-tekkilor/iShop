import 'package:flutter/material.dart';
import 'package:ishop/views/home/home_view.dart';
import 'package:ishop/views/login/login_view.dart';
import 'package:ishop/views/places/places_view.dart';

class Nav {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'places':
        return MaterialPageRoute(builder: (_) => PlacesView());
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
