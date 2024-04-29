import 'dart:convert';
import '../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

/// Sends requests to the server to get the other users locations.
class GetOtherUsersLocation extends SendRequest {

  // The auth token to authenticate the request.
  final AuthToken _token;

  /// Creates the object with the token to authenticate the request.
  GetOtherUsersLocation(this._token);

  /// Sends the request and retrieves the other users locations.
  Future<List<dynamic>> send() async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    String usersLocation = await get(headers);
    return json.decode(usersLocation);
  }

  /// Returns the route within the server to the getOthersLocations endpoint.
  @override
  getRoute() {
    return "getOthersLocations";
  }
}
