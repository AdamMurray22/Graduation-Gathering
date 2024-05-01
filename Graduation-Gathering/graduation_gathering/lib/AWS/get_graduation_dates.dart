import 'dart:convert';
import '../Auth/auth_token.dart';
import '../Location/location.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

import 'graduation_dates.dart';

/// Sends requests to the server to set your location.
class GetGraduationDates extends SendRequest {

  // The auth token to authenticate the request.
  final AuthToken _token;

  /// Creates the object with the token to authenticate the request.
  GetGraduationDates(this._token);

  /// Sends the request.
  Future<GraduationDates> send() async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    String responseBody = await get(headers);
    List<dynamic> responseJson = json.decode(
        responseBody);
    return GraduationDates(responseJson);
  }

  /// Returns the route within the server to the getGraduationDates endpoint.
  @override
  getRoute() {
    return "getGraduationDates";
  }
}
