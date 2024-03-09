import 'dart:convert';
import '../Auth/auth_token.dart';
import 'package:graduation_gathering/AWS/send_request.dart';

class GetOtherUsersLocation extends SendRequest {

  final AuthToken _token;

  GetOtherUsersLocation(this._token);

  Future<List<dynamic>> send() async {
    Map<String, String> headers = {"Authorization": _token.getToken()};
    String usersLocation = await get(headers);
    return json.decode(usersLocation);
  }

  @override
  getRoute() {
    return "getOthersLocations";
  }
}
