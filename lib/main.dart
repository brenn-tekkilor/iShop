import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/pages/admin/admin_page.dart';
import 'package:ishop/pages/login/login_page.dart';
import 'package:ishop/utils/colors.dart';
import 'package:ishop/utils/custom_route.dart';
import 'package:ishop/widgets/loading.dart';

import 'file:///C:/Users/brenn/source/repos/brenn/ishop/lib/pages/home/home_page.dart';

void main() => runApp(MyApp());

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('Error initializing FireBase!'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                        return CustomRoute(
                          builder: (_) => LoginPage(),
                          settings: settings,
                        );

                      case '/home':
                        return CustomRoute(
                          builder: (_) => HomePage(),
                          settings: settings,
                        );

                      case '/admin':
                        return CustomRoute(
                          builder: (_) => AdminPage(),
                          settings: settings,
                        );

                      default:
                        return CustomRoute(
                          builder: (_) => LoginPage(),
                          settings: settings,
                        );
                    }
                  },
                  initialRoute: '/login',
                  home: HomePage(),
                );
              },
            );
          }
          return Loading();
        });
  }
}
