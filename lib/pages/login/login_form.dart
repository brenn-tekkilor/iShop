import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishop/pages/home/home_page.dart';
import 'package:ishop/providers/auth_service.dart';
import 'package:ishop/widgets/basic_button.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> usernameKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> passwordKey =
      GlobalKey<FormFieldState<String>>();

  void _onSubmitForm(AuthService auth) {
    auth.signInWithEmailAndPassword(
        usernameKey.currentState.value, passwordKey.currentState.value);
  }

  void _onGoogleSignIn(AuthService auth) {
    auth.signInWithGoogle();
  }

  Widget get _googleSignInButton {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: BasicButton('Google Account'),
    );
  }

  Widget get _submitButton {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: BasicButton('Sign In'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var _isUserAuthorized = context.select<AuthService, bool>(
      (authService) => authService.isUserAuthorized,
    );
    if (_isUserAuthorized != null && _isUserAuthorized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return HomePage();
            },
          ),
        );
      });
    }
    return Container(
      width: width,
      height: height,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Form'),
        ),
        body: Container(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    key: usernameKey,
                    style: Theme.of(context).textTheme.headline1,
                    decoration: InputDecoration(
                      hintText: 'username',
                      icon: Icon(Icons.account_circle_outlined),
                    ),
                  ),
                  TextFormField(
                      key: passwordKey,
                      style: Theme.of(context).textTheme.headline1,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'password',
                        icon: Icon(Icons.lock_outline),
                      )),
                  InkWell(
                    child: _submitButton,
                    onTap: () => _onSubmitForm(auth),
                  ),
                  InkWell(
                    child: _googleSignInButton,
                    onTap: () => _onGoogleSignIn(auth),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
