import 'dart:convert';

import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:graduation_gathering/Map/Zones/grad_zone.dart';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';

import '../AWS/send_request.dart';
import '../Profile/profile_settings.dart';

class GetUserProfile extends SendRequest {

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

  @override
  getRoute() {
    return "getUserProfile";
  }
}
