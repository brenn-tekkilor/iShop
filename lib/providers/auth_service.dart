import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  AuthService._create() {
    _auth ??= FirebaseAuth.instance;
    _auth.authStateChanges().listen(onAuthStateChange);
  }
  static AuthService getInstance() {
    _instance ??= AuthService._create();
    return _instance;
  }

  static AuthService _instance;
  FirebaseAuth _auth;
  UserCredential _userCredential;
  bool _isUserAuthorized;

  Future<void> onAuthStateChange(User user) async {
    if (user == null) {
      print('Unable to Authenticate User.  Please sign in.');
    } else {
      await _auth.currentUser.getIdTokenResult().then((idTokenResult) async {
        final token = await idTokenResult;
        isUserAuthorized = (!!token.claims['admin']);
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) async {
        _userCredential = await userCredential ?? _userCredential;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final account = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final details = await account.authentication;
    // create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: details.accessToken,
      idToken: details.idToken,
    );
    _userCredential =
        await _auth.signInWithCredential(credential) ?? _userCredential;
  }

  bool get isUserAuthorized => _isUserAuthorized;

  set isUserAuthorized(bool value) {
    _isUserAuthorized = value;
    notifyListeners();
  }
}
