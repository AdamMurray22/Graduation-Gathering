import 'dart:convert';
import '../Auth/auth_token.dart';
import '../Location/location.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

/// Sends requests to the server to set your location.
class GetGraduationDates extends SendRequest {

  // The auth token to authenticate the request.
  final AuthToken _token;

  /// Creates the object with the token to authenticate the request.
  GetGraduationDates(this._token);

  /// Sends the request.
  send() {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    get(headers);
  }

  /// Returns the route within the server to the getGraduationDates endpoint.
  @override
  getRoute() {
    return "getGraduationDates";
  }
}
