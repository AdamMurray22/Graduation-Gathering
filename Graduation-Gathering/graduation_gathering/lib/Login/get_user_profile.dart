import 'dart:convert';

import 'package:graduation_gathering/Auth/auth_token.dart';

import '../AWS/send_request.dart';
import '../Profile/profile_settings.dart';

class GetUserProfile extends SendRequest {

  Future<ProfileSettings> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    Map<String, dynamic> responseJson = json.decode(responseBody);
    print(responseJson);
    return ProfileSettings(responseJson["hasLoggedInBefore"], responseJson["id"],
      responseJson["email"], responseJson["accountType"],
      responseJson["name"], responseJson["faculty"],
      responseJson["school"], responseJson["course"]);
  }

  @override
  getRoute() {
    return "getUserProfile";
  }
}
