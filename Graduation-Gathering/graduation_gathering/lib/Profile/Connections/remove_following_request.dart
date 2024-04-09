import 'dart:convert';

import '../../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

import 'connection_profile.dart';

class RemoveFollowingRequest extends SendRequest {

  final AuthToken _token;

  RemoveFollowingRequest(this._token);

  send(ConnectionProfile profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = {"userId": profile.getId()};
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  @override
  getRoute() {
    return "removeFollowingRequest";
  }
}
