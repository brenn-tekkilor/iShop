import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/nav.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/app/styles.dart';
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
          setupLocator();
          return snapshot.hasData
              ? FutureBuilder(
                  future: locator.allReady(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      snapshot.hasData
                          ? MaterialApp(
                              title: 'iShop',
                              theme: AppStyles.primaryTheme,
                              initialRoute: 'login',
                              onGenerateRoute: Nav.generateRoute)
                          : CircularProgressIndicator())
              : CircularProgressIndicator();
        });
  }
}
