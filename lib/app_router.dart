import 'package:flutter/material.dart';
import 'package:ishop/app/home/home_view.dart';
import 'package:ishop/app/login/login_view.dart';
import 'package:ishop/app/places/places_view.dart';
import 'package:ishop/dev/dev.dart';

/// Route Arguments
class RouteArguments {
  /// Route Arguments constructor
  const RouteArguments({this.isAuthorized = false});

  /// is authorized
  final bool isAuthorized;
}

/// App Router
abstract class AppRouter {
  //// generate route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final a = settings.arguments;
    final b = a is RouteArguments ? a : const RouteArguments();
    final s = b.isAuthorized ? settings : const RouteSettings(name: 'login');
    switch (s.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const HomeView());
      case 'login':
        return MaterialPageRoute<dynamic>(builder: (_) => LoginView());
      case 'places':
        return MaterialPageRoute<dynamic>(builder: (_) => const PlacesView());
      case 'dev':
        return MaterialPageRoute<dynamic>(builder: (_) => Dev());
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
