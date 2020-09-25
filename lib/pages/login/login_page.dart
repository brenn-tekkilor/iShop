import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:ishop/pages/login/login_form.dart';
import 'package:ishop/providers/auth_service.dart';
import 'package:ishop/utils/styles.dart';
import 'package:ishop/widgets/whiteTick.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final AuthService _authservice = AuthService.getInstance();
  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return ChangeNotifierProvider(
      create: (context) => _authservice,
      child: Scaffold(
        body: Container(
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
                        Tick(image: tick),
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
