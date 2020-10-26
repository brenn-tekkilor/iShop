// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../components/home/home_view.dart';
import '../../components/login/login_view.dart';
import '../../components/map/map_view.dart';
import '../../components/places/places_view.dart';

class Routes {
  static const String loginView = '/';
  static const String homeView = '/home-view';
  static const String placesView = '/places-view';
  static const String mapView = '/map-view';
  static const all = <String>{
    loginView,
    homeView,
    placesView,
    mapView,
  };
}

class AppRoutes extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.placesView, page: PlacesView),
    RouteDef(Routes.mapView, page: MapView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<LoginView>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<HomeView>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    PlacesView: (data) {
      return MaterialPageRoute<PlacesView>(
        builder: (context) => const PlacesView(),
        settings: data,
      );
    },
    MapView: (data) {
      return MaterialPageRoute<MapView>(
        builder: (context) => MapView(),
        settings: data,
      );
    },
  };
}
