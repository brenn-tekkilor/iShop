import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/login/login_provider.dart';
import 'package:ishop/app_router.dart';
import 'package:ishop/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

Future<FirebaseApp> initialize() async => await Firebase.initializeApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          snapshot.hasData
              ? ChangeNotifierProvider<LoginProvider>(
                  create: (context) => LoginProvider(),
                  child: MaterialApp(
                    title: 'iShop',
                    theme: AppStyles.primaryTheme,
                    initialRoute: 'login',
                    onGenerateRoute: AppRouter.generateRoute,
                  ),
                )
              : CircularProgressIndicator());
}
