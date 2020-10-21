import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuple/tuple.dart';

class UserAccount {
  UserAccount({this.id = '', this.email = ''});
  factory UserAccount.initial() {
    return UserAccount();
  }
  UserAccount.fromJson(Map<String, dynamic> json) {
    token = json['credential'];
    id = json['id'];
    email = json['email'];
  }
  UserCredential credential;
  IdTokenResult token;
  String id;
  String email;

  bool get isAuthenticated => (credential != null) ? true : false;
  bool get isAuthorized =>
      ((token != null && !!token.claims['admin']) || isAuthenticated)
          ? true
          : false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
      };

  //#region getter/setter info
  Tuple2<String, String> get info => Tuple2(id, email);
  set info(Tuple2<String, String> value) {
    assert(value != null);
    id = value.item1 ?? id;
    email = value.item2 ?? email;
  }
  //#endregion
//#endregion

}
