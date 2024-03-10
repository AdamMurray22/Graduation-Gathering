import 'dart:convert';
import 'package:graduation_gathering/Profile/profile_settings.dart';

import '../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

class SetUserProfile extends SendRequest {

  final AuthToken _token;

  SetUserProfile(this._token);

  send(ProfileSettings profile) async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, dynamic> bodyJson = profile.toJson();
    String body = json.encode(bodyJson);
    await post(body, headers: headers);
  }

  @override
  getRoute() {
    return "setUserProfile";
  }
}
