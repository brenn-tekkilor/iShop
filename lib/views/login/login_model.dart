import 'package:flutter/foundation.dart';
import 'package:ishop/app/service_locator.dart';
import 'package:ishop/core/enums/view_state.dart';
import 'package:ishop/services/login_service.dart';
import 'package:ishop/views/base/base_model.dart';

class LoginModel extends BaseModel {
  LoginModel() : _srv = locator<LoginService>();
  factory LoginModel.initial() {
    return LoginModel();
  }
  final LoginService _srv;

  ValueNotifier<bool> get isAuthorized => _srv.isAuthorizedNotifier;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    setState(ViewState.busy);
    await _srv
        .signInWithEmailAndPassword(email, password)
        .then((value) async => await value)
        .catchError((e) => print(e))
        .whenComplete(() => setState(ViewState.idle));
  }

  Future<void> signInWithGoogle() async {
    setState(ViewState.busy);
    await _srv.signInWithGoogle().whenComplete(() => setState(ViewState.idle));
  }

  //#endregion

}
