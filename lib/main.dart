import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/pages/admin/admin_page.dart';
import 'package:ishop/pages/login/login_page.dart';
import 'package:ishop/pages/poi/poi_page.dart';
import 'package:ishop/utils/colors.dart';

import 'file:///C:/Users/brenn/source/repos/brenn/ishop/lib/pages/home/home_page.dart';

void main() => runApp(MyApp());

Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Text(
              'Error initializing FireBase!',
              textDirection: TextDirection.ltr,
            ));
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return DynamicTheme(
            defaultBrightness: Brightness.dark,
            data: (brightness) => ThemeData(
              fontFamily: 'Quicksand',
              primaryColor: MyColors.primary,
              accentColor: MyColors.accent,
              brightness: brightness, // default is dark
            ),
            themedWidgetBuilder: (context, theme) {
              return MaterialApp(
                title: 'iShop',
                theme: theme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case '/login':
                      return MaterialPageRoute(
                        builder: (context) => LoginPage(),
                        settings: settings,
                      );

                    case '/home':
                      return MaterialPageRoute(
                        builder: (context) => HomePage(),
                        settings: settings,
                      );

                    case '/poi':
                      return MaterialPageRoute(
                        builder: (context) => POIPage(),
                        settings: settings,
                      );

                    case '/admin':
                      return MaterialPageRoute(
                        builder: (context) => AdminPage(),
                        settings: settings,
                      );

                    default:
                      return MaterialPageRoute(
                        builder: (context) => LoginPage(),
                        settings: settings,
                      );
                  }
                },
                initialRoute: '/login',
              );
            },
          );
        });
  }
}
