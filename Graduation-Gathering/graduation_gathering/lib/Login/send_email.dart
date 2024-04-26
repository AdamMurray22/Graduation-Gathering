import 'dart:convert';
import '../AWS/send_request.dart';

/// Sends the requests to the server containing the email the user is trying to login with.
class SendEmail extends SendRequest {

  /// Sends the request with the email the user is trying to login with.
  send(String email) {
    Map<String, String> bodyJson = {"email": email};
    String body = json.encode(bodyJson);
    post(body);
  }

  /// Returns the route within the server to the sendEmailCode endpoint.
  @override
  getRoute() {
    return "sendEmailCode";
  }
}
