import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ishop/data/service/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider() : _api = AuthService() {
    _tokenStream = _api.tokenStream.listen(_onTokenChange);
  }

  final AuthService _api;
  bool _isAuthorized = false;

  late StreamSubscription<IdTokenResult> _tokenStream;

  GlobalKey<FormState> get formKey => _api.formKey;
  GlobalKey<FormFieldState<String>> get emailKey => _api.emailKey;
  GlobalKey<FormFieldState<String>> get passwordKey => _api.passwordKey;

  void signInWithEmailAndPassword() => _api.signInWithEmailAndPassword();
  void signInWithGoogle() => _api.signInWithGoogle();

  @override
  void dispose() {
    _tokenStream.cancel();
    super.dispose();
  }

  void _onTokenChange(IdTokenResult value) {
    isAuthorized = (value.claims['admin']);
  }

  bool get isAuthorized => _isAuthorized;
  set isAuthorized(bool value) {
    if (_isAuthorized != value) {
      _isAuthorized = value;
      notifyListeners();
    }
  }
}
