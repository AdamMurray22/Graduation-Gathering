import 'dart:convert';

import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';

import '../AWS/send_request.dart';
import '../Profile/profile_settings.dart';

/// Sends requests to the server to get the users profile.
class GetUserProfile extends SendRequest {

  /// Sends the request and retrieves the users profile.
  Future<ProfileSettings> send(AuthToken token, GradZones allZones) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    Map<String, dynamic> responseJson = json.decode(responseBody);
    List<dynamic> userZonesIds = responseJson["userGradZoneIds"];
    GradZones userZones = GradZones([]);
    for (GradZone zone in allZones) {
      for (String id in userZonesIds)
      {
        if (id == zone.getId())
        {
          userZones.addZone(zone);
        }
      }
    }
    return ProfileSettings(responseJson["hasLoggedInBefore"], responseJson["id"],
      responseJson["email"], responseJson["accountType"],
      responseJson["name"], responseJson["faculty"],
      responseJson["school"], responseJson["course"], userZones);
  }

  /// Returns the route within the server to the getUserProfile endpoint.
  @override
  getRoute() {
    return "getUserProfile";
  }
}
