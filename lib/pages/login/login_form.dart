import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishop/providers/auth_service.dart';
import 'package:ishop/widgets/basic_button.dart';
import 'package:ishop/widgets/input_field.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthService _authService() => AuthService.getInstance();

  Future<void> _onSubmitForm() async {
    await _authService().signInWithEmailAndPassword(
        _usernameController.text, _passwordController.text);
  }

  Future<void> _onGoogleSignIn() async {
    await _authService().signInWithGoogle();
  }

  Widget _buildGoogleSignInButton(Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: InkWell(onTap: onTap, child: BasicButton('Google Account')),
    );
  }

  Widget _buildFormSubmitButton(Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: InkWell(onTap: onTap, child: BasicButton('Sign In')),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _isUserAuthorized = context.select<AuthService, bool>(
      (authService) => authService.isUserAuthorized,
    );
    if (_isUserAuthorized != null && _isUserAuthorized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputField(
                    _usernameController,
                    hint: 'Username',
                    obscure: false,
                    icon: Icons.person_outline,
                  ),
                  InputField(
                    _passwordController,
                    hint: 'Password',
                    obscure: true,
                    icon: Icons.lock_outline,
                  ),
                  _buildFormSubmitButton(_onSubmitForm),
                  _buildGoogleSignInButton(_onGoogleSignIn),
                ],
              )),
        ],
      ),
    );
  }
}
