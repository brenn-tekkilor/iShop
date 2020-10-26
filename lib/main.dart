import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/app/services/router.gr.dart';
import 'package:ishop/app/styles/styles.dart';
import 'package:logger/logger.dart';

void main() {
  Logger.level = Level.verbose;
  runApp(MyApp());
}

Future<FirebaseApp> initialize() async => await Firebase.initializeApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          configureDependencies();
          return snapshot.hasData
              ? FutureBuilder(
                  future: locator.allReady(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      snapshot.hasData
                          ? GetMaterialApp(
                              title: 'iShop',
                              onGenerateRoute: AppRoutes().onGenerateRoute,
                              builder: ExtendedNavigator.builder<AppRoutes>(
                                router: AppRoutes(),
                                builder: (context, extendedNav) => Theme(
                                  data: AppStyles.primaryTheme,
                                  child: extendedNav,
                                ),
                              ),
                            )
                          : CircularProgressIndicator())
              : CircularProgressIndicator();
        });
  }
}
