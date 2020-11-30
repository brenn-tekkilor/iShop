import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ishop/data/service/auth_service.dart';

/// Login Service Provider
class LoginProvider extends ChangeNotifier {
  /// Constructor
  LoginProvider() : _api = AuthService() {
    _tokenStream = _api.tokenStream.listen(_onTokenChange);
  }

  final AuthService _api;
  bool _isAuthorized = false;

  late StreamSubscription<IdTokenResult> _tokenStream;

  /// login form key
  GlobalKey<FormState> get formKey => _api.formKey;

  /// login form email text input field key
  GlobalKey<FormFieldState<String>> get emailKey => _api.emailKey;

  /// login form password text input field key
  GlobalKey<FormFieldState<String>> get passwordKey => _api.passwordKey;

  /// attempts to sign a user in using email and password credentials
  void signInWithEmailAndPassword() => _api.signInWithEmailAndPassword();

  /// attempts to sign a user in using a Google account
  void signInWithGoogle() => _api.signInWithGoogle();

  @override
  void dispose() {
    _tokenStream.cancel();
    super.dispose();
  }

  void _onTokenChange(IdTokenResult value) {
    var a = value.claims.containsKey('admin');
    if (a) {
      final dynamic b = value.claims['admin'];
      if (b is bool) {
        a = b;
      }
    }
    isAuthorized = a;
  }

  /// returns true if the user is authorized
  bool get isAuthorized => _isAuthorized;

  /// sets the user authorization
  set isAuthorized(bool value) {
    if (_isAuthorized != value) {
      _isAuthorized = value;
      notifyListeners();
    }
  }
}
