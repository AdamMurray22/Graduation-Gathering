import 'dart:convert';
import 'package:graduation_gathering/Profile/profile_settings.dart';

import '../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

/// Sends requests to the server to set the user profile..
class SetUserProfile extends SendRequest {

  final AuthToken _token;

  SetUserProfile(this._token);

  /// Sends the request to set the user profile..
  send(ProfileSettings profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = profile.toJson();
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  /// Returns the route within the server to the setUserProfile endpoint.
  @override
  getRoute() {
    return "setUserProfile";
  }
}
