import 'dart:convert';

import '../../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

import 'connection_profile.dart';

/// Sends requests to the server to send a follow request to another user.
class SendFollowRequest extends SendRequest {

  final AuthToken _token;

  SendFollowRequest(this._token);

  /// Sends the request to send a follow request to another user.
  send(ConnectionProfile profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = {"userId": profile.getId()};
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  /// Returns the route within the server to the sendConnectionRequest endpoint.
  @override
  getRoute() {
    return "sendConnectionRequest";
  }
}
