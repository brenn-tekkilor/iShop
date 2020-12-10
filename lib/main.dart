// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/app_provider.dart';
import 'package:ishop/app/login/auth_provider.dart';
import 'package:ishop/app_router.dart';
import 'package:ishop/app_styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const IShopApp());
}

/// initialize firebase app
// ignore: unnecessary_await_in_return
Future<FirebaseApp> initialize() async => await Firebase.initializeApp();

/// IShop app main entry point and root widget.
class IShopApp extends StatelessWidget {
  /// IShopApp default const constructor
  const IShopApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) => snapshot.hasData
          ? MultiProvider(
              providers: [
                ChangeNotifierProvider<AppProvider>(
                    create: (context) => AppProvider()),
                ChangeNotifierProvider<AuthProvider>(
                    create: (context) => AuthProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'iShop',
                theme: primaryTheme,
                initialRoute: 'login',
                onGenerateRoute: AppRouter.generateRoute,
              ),
            )
          : const CircularProgressIndicator());
}
