import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  LoginService()
      : _fireAuth = FirebaseAuth.instance,
        _isAuthorizedNotifier = ValueNotifier<bool>(false),
        _formErrMsg = '' {
    _fireAuth.authStateChanges().listen(_onAuthStateChange);
  }

  factory LoginService.initial() {
    return LoginService();
  }

  final FirebaseAuth _fireAuth;
  final ValueNotifier<bool> _isAuthorizedNotifier;
  ValueNotifier<bool> get isAuthorizedNotifier => _isAuthorizedNotifier;
  String _formErrMsg;

  void _onAuthStateChange(User value) async {
    if (value != null) {
      final t = await _fireAuth.currentUser.getIdTokenResult();
      _isAuthorizedNotifier.value = (t != null && t.claims['admin']);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email == null || email.isEmpty) {
      _formErrMsg += 'Email is required to sign in.\n';
    }
    if (password == null || password.isEmpty) {
      _formErrMsg += 'Password is required to sign in.\n';
    }
    if (_formErrMsg.isEmpty) {
      await _fireAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async => await value)
          .catchError((e) => print(e));
    }
    //#endregion
  }

  //#region signInWithGoogle()
  Future<void> signInWithGoogle() async => await GoogleSignIn()
      .signIn()
      .then((account) async => await account.authentication)
      .then((details) async => await _fireAuth
          .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: details.accessToken,
            idToken: details.idToken,
          ))
          .then((value) async => await value)
          .catchError((e) => print(e)))
      .catchError((e) => print(e))
      .catchError((e) => print(e));
  //#endregion
}
