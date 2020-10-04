import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishop/pages/login/login_form.dart';
import 'package:ishop/providers/auth_service.dart';
import 'package:ishop/utils/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      builder: (context, _) => Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: backgroundImage,
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                const Color.fromRGBO(162, 146, 199, 0.8),
                const Color.fromRGBO(51, 51, 63, 0.9),
              ],
              stops: [0.2, 1.0],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            )),
            child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        LoginForm(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
