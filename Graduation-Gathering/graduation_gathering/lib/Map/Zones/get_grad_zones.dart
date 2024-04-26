import 'dart:convert';
import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import '../../AWS/send_request.dart';
import '../../Auth/auth_token.dart';

/// Sends requests to the server to get the Graduation Zones.
class GetGradZones extends SendRequest {

  /// Sends the request and returns the grad zones.
  Future<GradZones> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return GradZones(responseJson);
  }

  /// Returns the route within the server to the getGradZones endpoint.
  @override
  getRoute() {
    return "getGradZones";
  }
}