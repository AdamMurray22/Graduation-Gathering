import 'dart:convert';

import '../../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

import 'connection_profile.dart';

/// Sends requests to the server to remove a follower request.
class RemoveFollowerRequest extends SendRequest {

  final AuthToken _token;

  RemoveFollowerRequest(this._token);

  /// Sends the request to remove a follower request.
  send(ConnectionProfile profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = {"userId": profile.getId()};
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  /// Returns the route within the server to the removeFollowerRequest endpoint.
  @override
  getRoute() {
    return "removeFollowerRequest";
  }
}
