import 'dart:convert';
import 'package:tuple/tuple.dart';

import '../AWS/send_request.dart';

/// Sends the requests to the server containing the login code to authenticate.
class SendCode extends SendRequest {

  /// Sends the request and retrieves auth token if the correct code is sent.
  Future<Tuple2<bool, String?>> send(String email, String code) async {
    Map<String, String> bodyJson = {"email": email ,"code": code};
    String body = json.encode(bodyJson);
    String responseBody = await post(body);
    Map<String, dynamic> responseJson = json.decode(responseBody);
    return Tuple2<bool, String?>(responseJson["validated"], responseJson["token"]);
  }

  /// Returns the route within the server to the validateCode endpoint.
  @override
  getRoute() {
    return "validateCode";
  }
}
