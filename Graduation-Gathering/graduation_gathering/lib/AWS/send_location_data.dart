import 'dart:convert';
import '../Auth/auth_token.dart';
import '../Location/location.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

class SendLocationData extends SendRequest {

  final AuthToken _token;

  SendLocationData(this._token);

  send(Location location) {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    Map<String, Map<String, double>> bodyJson = {"location": {"lat": location.getLatitude(), "long": location.getLongitude()}};
    String body = json.encode(bodyJson);
    post(body, headers: headers);
  }

  @override
  getRoute() {
    return "setLocation";
  }
}
