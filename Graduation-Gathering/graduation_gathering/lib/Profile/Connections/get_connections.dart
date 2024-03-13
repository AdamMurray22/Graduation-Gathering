import 'dart:convert';

import 'package:graduation_gathering/Profile/Connections/connections.dart';

import '../../AWS/send_request.dart';
import '../../Auth/auth_token.dart';
import 'other_user_profiles.dart';



class GetConnections extends SendRequest {

  Future<Connections> send(AuthToken token, OtherUserProfiles allOtherUserProfiles) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return Connections(responseJson, allOtherUserProfiles);
  }

  @override
  getRoute() {
    return "getConnections";
  }
}