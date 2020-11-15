import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishop/app/login/login_provider.dart';
import 'package:ishop/app/widget/basic_button.dart';
import 'package:ishop/app_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    if (kDebugMode) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Navigator.pushNamed(context, '/'));
    }

     */
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context) as ThemeData;
    return Consumer<LoginProvider>(builder: (context, auth, child) {
      if (auth.isAuthorized) {
        WidgetsBinding.instance
            ?.addPostFrameCallback((_) => Navigator.pushNamed(context, '/',
                arguments: RouteArguments(
                  isAuthorized: auth.isAuthorized,
                )));
      }
      return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: auth.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      key: auth.emailKey,
                      style: theme.textTheme.headline1,
                      decoration: InputDecoration(
                        hintText: 'username',
                        icon: Icon(Icons.account_circle_outlined),
                      ),
                    ),
                    TextFormField(
                      key: auth.passwordKey,
                      style: theme.textTheme.headline1,
                      obscureText: true,
                      decoration: InputDecoration(
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
