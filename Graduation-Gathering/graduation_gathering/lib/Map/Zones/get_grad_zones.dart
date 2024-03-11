import 'dart:convert';

import 'package:graduation_gathering/Map/Zones/grad_zones.dart';

import '../../AWS/send_request.dart';
import '../../Auth/auth_token.dart';


class GetGradZones extends SendRequest {

  Future<GradZones> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return GradZones(responseJson);
  }

  @override
  getRoute() {
    return "getGradZones";
  }
}