import 'dart:convert';

import 'package:graduation_gathering/Profile/Connections/connections.dart';

import '../../AWS/send_request.dart';
import '../../Auth/auth_token.dart';
import 'other_user_profiles.dart';

class GetAllOtherUsersProfiles extends SendRequest {

  Future<OtherUserProfiles> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return OtherUserProfiles(responseJson);
  }

  @override
  getRoute() {
    return "getAllOtherUsersProfiles";
  }
}