import 'dart:convert';

import '../../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

import 'connection_profile.dart';

/// Sends requests to the server to grant a different users follow request.
class GrantFollowerRequest extends SendRequest {

  final AuthToken _token;

  GrantFollowerRequest(this._token);

  /// Sends the request to grant a users follow permission.
  send(ConnectionProfile profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = {"userId": profile.getId()};
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  /// Returns the route within the server to the grantFollowerRequest endpoint.
  @override
  getRoute() {
    return "grantFollowerRequest";
  }
}
