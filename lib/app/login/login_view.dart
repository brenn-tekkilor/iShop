import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishop/app/login/auth_provider.dart';
import 'package:ishop/com/basic_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

/// LoginView
class LoginView extends StatelessWidget {
  /// LoginView constructor
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      if (auth.isAuthorized) {
        WidgetsBinding.instance?.addPostFrameCallback((_) =>
            Navigator.of(context)?.pushNamed('/', arguments: <String, dynamic>{
              'auth': auth,
            }));
      }
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: auth.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      key: auth.emailKey,
                      style: Theme.of(context).primaryTextTheme.headline4,
                      decoration: const InputDecoration(
                        hintText: 'username',
                        icon: Icon(Icons.account_circle_outlined),
                      ),
                    ),
                    TextFormField(
                      key: auth.passwordKey,
                      style: Theme.of(context).primaryTextTheme.headline4,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'password',
                        icon: Icon(Icons.lock_outline),
                      ),
                    ),
                    BasicButton(
                      text: 'SIGN IN',
                      onTap: () => auth.signInWithEmailAndPassword(),
                    ),
                    BasicButton(
                      text: 'Google Account',
                      onTap: () => auth.signInWithGoogle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
