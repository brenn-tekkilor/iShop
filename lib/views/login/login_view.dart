import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/core/enums/view_state.dart';
import 'package:ishop/core/widgets/basic_button.dart';
import 'package:ishop/views/base/base_view.dart';
import 'package:ishop/views/login/login_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> emailKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> passwordKey =
      GlobalKey<FormFieldState<String>>();

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
    return FutureBuilder(
        future: locator.allReady(),
        builder: (context, snapshot) => snapshot.hasData
            ? BaseView<LoginModel>(builder: (context, model, child) {
                return ValueListenableBuilder(
                  builder:
                      (BuildContext context, bool isAuthorized, Widget child) {
                    if (!!model.isAuthorized.value) {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => Navigator.pushNamed(context, '/'));
                    }
                    return child;
                  },
                  child: Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        model.state == ViewState.busy
                            ? CircularProgressIndicator()
                            : Container(
                                width: width,
                                height: height,
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Form(
                                  key: formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: ListView(
                                    children: <Widget>[
                                      TextFormField(
                                        key: emailKey,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        decoration: InputDecoration(
                                          hintText: 'username',
                                          icon: Icon(
                                              Icons.account_circle_outlined),
                                        ),
                                      ),
                                      TextFormField(
                                          key: passwordKey,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'password',
                                            icon: Icon(Icons.lock_outline),
                                          )),
                                      BasicButton(
                                        'SIGN IN',
                                        () async => await model
                                            .signInWithEmailAndPassword(
                                                emailKey.currentState.value,
                                                passwordKey.currentState.value),
                                      ),
                                      BasicButton(
                                        'Google Account',
                                        () async =>
                                            await model.signInWithGoogle(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  valueListenable: model.isAuthorized,
                );
              })
            : CircularProgressIndicator());
  }
}
