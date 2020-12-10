import 'package:flutter/material.dart';
import 'package:ishop/app/home/home_view.dart';
import 'package:ishop/app/login/auth_provider.dart';
import 'package:ishop/app/login/login_view.dart';
import 'package:ishop/app/places/places_view.dart';
import 'package:ishop/dev/dev.dart';

/// App Router
abstract class AppRouter {
  //// generate route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final a = settings.arguments;
    final b = a is Map<String, dynamic> ? a : <String, dynamic>{};
    final dynamic c = b.containsKey('auth') ? b['auth'] : null;
    final d = c is AuthProvider ? c : AuthProvider();
    final e = d.isAuthorized ? settings : const RouteSettings(name: 'login');
    switch (e.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const HomeView());
      case 'login':
        return MaterialPageRoute<dynamic>(builder: (_) => const LoginView());
      case 'places':
        return MaterialPageRoute<dynamic>(builder: (_) => const PlacesView());
      case 'dev':
        return MaterialPageRoute<dynamic>(builder: (_) => const Dev());
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
