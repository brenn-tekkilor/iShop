import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/pages/login/login_page.dart';
import 'package:ishop/utils/colors.dart';

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
                home: LoginPage(),
              );
            },
          );
        });
  }
}
