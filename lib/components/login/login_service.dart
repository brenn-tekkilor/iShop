import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/core/util/scribe.dart';

@lazySingleton
class LoginService {
  //#region Ctors
  LoginService()
      : _fireAuth = FirebaseAuth.instance,
        _isAuthorizedNotifier = ValueNotifier<bool>(false) {
    _fireAuth.authStateChanges().listen(_onAuthStateChange);
  }

  @factoryMethod
  factory LoginService.initial() {
    return LoginService();
  }
  //#endregion

  //#region properties
  final FirebaseAuth _fireAuth;
  final ValueNotifier<bool> _isAuthorizedNotifier;
  ValueNotifier<bool> get isAuthorizedNotifier => _isAuthorizedNotifier;
  bool get isAuthorized => _isAuthorizedNotifier.value;
  //#endregion

  //#region static Global Keys
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  static GlobalKey<FormFieldState<String>> get emailKey => _emailKey;
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  static GlobalKey<FormFieldState<String>> get passwordKey => _passwordKey;
  //#endregion

  //#region Future<void> _onAuthStateChange
  Future<void> _onAuthStateChange(User value) async =>
      await _fireAuth.currentUser
          .getIdTokenResult()
          .then((value) async =>
              _isAuthorizedNotifier.value = (!!((await value).claims['admin'])))
          .catchError((e) => print(e));
//#endregion

  Future<void> signInWithEmailAndPassword() async {
    if (_isFormValidated) {
      await _fireAuth.signInWithEmailAndPassword(
          email: _emailKey.currentState.value,
          password: _passwordKey.currentState.value);
    }
  }

  //#region Future<void> signInWithGoogle()
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
  bool get _isFormValidated {
    return (Scribe.isNotNullOrEmpty(_emailKey.currentState.value) &&
        Scribe.isNotNullOrEmpty(_passwordKey.currentState.value));
  }
}
