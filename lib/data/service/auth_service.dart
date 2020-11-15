import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  ////#region AuthService() Ctor
  AuthService()
      : _fireAuth = FirebaseAuth.instance,
        formKey = GlobalKey<FormState>(),
        emailKey = GlobalKey<FormFieldState<String>>(),
        passwordKey = GlobalKey<FormFieldState<String>>(),
        _tokenStreamController = StreamController<IdTokenResult>() {
    _tokenStreamController.onListen =
        _tokenStreamController.onResume = _startTokenStream;
    _tokenStreamController.onPause =
        _tokenStreamController.onCancel = _stopTokenStream;
  }
  ////#endregion
  ////#region properties
  // FirebaseAuth.instance
  final FirebaseAuth _fireAuth;
  ////#region Login form state
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState<String>> emailKey;
  String get emailFormField => emailKey.currentState?.value ?? '';
  final GlobalKey<FormFieldState<String>> passwordKey;
  String get passwordFormField => passwordKey.currentState?.value ?? '';
  ////#endregion
  ////#region authentication state streams
  // _fireAuth.authStateChanges.listen  => _updateToken()
  StreamSubscription<User>? _authStateChange;
  // on listen/resume => _authStateChange.listen
  // on pause/cancel => _authStateChange.cancel
  final StreamController<IdTokenResult> _tokenStreamController;
  // emits IdTokenResult
  Stream<IdTokenResult> get tokenStream => _tokenStreamController.stream;
  ////#endregion
  ////#endregion
  ////#region methods
  ////#region _tokenStreamController callbacks
  // _tokenStreamController.on[listen|Resume]
  void _startTokenStream() {
    _authStateChange = _fireAuth.authStateChanges().listen(_updateToken);
  }

  // _tokenStreamController.on[Pause|Cancel]
  void _stopTokenStream() {
    if (_authStateChange != null) {
      _authStateChange?.cancel();
      _authStateChange = null;
    }
  }

  ////#endregion
  // _fireAuth.signIn(email, password)
  void signInWithEmailAndPassword() {
    final e = emailFormField;
    final p = passwordFormField;
    if (emailFormField.isNotEmpty && passwordFormField.isNotEmpty) {
      _fireAuth
          .signInWithEmailAndPassword(email: e, password: p)
          .catchError((e) => print(e));
    }
  }

  // _fireAuth.getIdToken => _tokenStreamCtrl.add(IdTokenResult)
  void _updateToken(User user) {
    _fireAuth.currentUser.getIdTokenResult().then((value) {
      _tokenStreamController.add(value);
    }).catchError((e) => print(e));
  }

  // Google OAuth SignIn
  void signInWithGoogle() => GoogleSignIn()
      .signIn()
      .then((account) async => await account.authentication)
      .then((details) async => await _fireAuth
          .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: details.accessToken,
            idToken: details.idToken,
          ))
          .catchError((e) => print(e)))
      .catchError((e) => print(e));
  ////#endregion
}
