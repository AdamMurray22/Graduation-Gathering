import 'dart:convert';

import '../../AWS/send_request.dart';
import '../../Auth/auth_token.dart';
import 'other_user_profiles.dart';

/// Sends requests to the server to get the other users profiles.
class GetAllOtherUsersProfiles extends SendRequest {

  /// Sends the request and retrieves the other users profiles.
  Future<OtherUserProfiles> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return OtherUserProfiles(responseJson);
  }

  /// Returns the route within the server to the getAllOtherUsersProfiles endpoint.
  @override
  getRoute() {
    return "getAllOtherUsersProfiles";
  }
}