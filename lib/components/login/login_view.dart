import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishop/components/login/login_model.dart';
import 'package:ishop/core/enums/view_state.dart';
import 'package:ishop/core/widgets/basic_button.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<LoginModel>.reactive(
      builder: (context, model, child) => ValueListenableBuilder(
        builder: (context, isAuthorized, child) {
          if (!!isAuthorized) {
            model.navigateToHome();
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
                        key: model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              key: model.emailKey,
                              style: Theme.of(context).textTheme.headline1,
                              decoration: InputDecoration(
                                hintText: 'username',
                                icon: Icon(Icons.account_circle_outlined),
                              ),
                            ),
                            TextFormField(
                                key: model.passwordKey,
                                style: Theme.of(context).textTheme.headline1,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'password',
                                  icon: Icon(Icons.lock_outline),
                                )),
                            BasicButton(
                              'SIGN IN',
                              () async =>
                                  await model.signInWithEmailAndPassword(
                                      model.emailKey.currentState.value,
                                      model.passwordKey.currentState.value),
                            ),
                            BasicButton(
                              'Google Account',
                              () async => await model.signInWithGoogle(),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        valueListenable: model.isAuthorized,
      ),
      viewModelBuilder: () => LoginModel.initial(),
    );
  }
}
