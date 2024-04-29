import 'dart:convert';
import '../Auth/auth_token.dart';
import '../Location/location.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

/// Sends requests to the server to set your location.
class SendLocationData extends SendRequest {

  // The auth token to authenticate the request.
  final AuthToken _token;

  /// Creates the object with the token to authenticate the request.
  SendLocationData(this._token);

  /// Sends the request.
  send(Location location) {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, Map<String, double>> bodyJson = {"location": {"lat": location.getLatitude(), "long": location.getLongitude()}};
    String body = json.encode(bodyJson);
    post(body, headers: headers);
  }

  /// Returns the route within the server to the setLocation endpoint.
  @override
  getRoute() {
    return "setLocation";
  }
}
