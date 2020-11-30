import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/login/login_provider.dart';
import 'package:ishop/app_router.dart';
import 'package:ishop/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const IShopApp());
}

/// initialize firebase app
Future<FirebaseApp> initialize() async => await Firebase.initializeApp();

/// IShop app main entry point and root widget.
class IShopApp extends StatelessWidget {
  /// IShopApp default const constructor
  const IShopApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) => snapshot.hasData
          ? ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider(),
              child: MaterialApp(
                title: 'iShop',
                theme: AppStyles.primaryTheme,
                initialRoute: 'login',
                onGenerateRoute: AppRouter.generateRoute,
              ),
            )
          : const CircularProgressIndicator());
}
