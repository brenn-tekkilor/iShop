import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/app/services/router.gr.dart';
import 'package:ishop/components/base/base_model.dart';
import 'package:ishop/components/login/login_service.dart';
import 'package:ishop/core/enums/view_state.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class LoginModel extends BaseModel {
  LoginModel()
      : _srv = locator<LoginService>(),
        _navigationService = locator<NavigationService>();

  @factoryMethod
  factory LoginModel.initial() {
    return LoginModel();
  }
  final LoginService _srv;
  final NavigationService _navigationService;

  ValueNotifier<bool> get isAuthorized => _srv.isAuthorizedNotifier;
  GlobalKey<FormState> get formKey => LoginService.formKey;
  GlobalKey<FormFieldState<String>> get emailKey => LoginService.emailKey;
  GlobalKey<FormFieldState<String>> get passwordKey => LoginService.passwordKey;

  Future<void> navigateToHome() async =>
      await _navigationService.navigateTo(Routes.homeView);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    setState(ViewState.busy);
    await _srv
        .signInWithEmailAndPassword()
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
