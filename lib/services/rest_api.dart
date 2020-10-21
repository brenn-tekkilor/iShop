import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ishop/core/models/user_account.dart';

/// The service responsible for networking requests
class RestApi {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = http.Client();

  Future<UserAccount> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');

    // Convert and return
    return UserAccount.fromJson(json.decode(response.body));
  }
}
