import 'dart:convert';
import '../AWS/send_request.dart';

class SendEmail extends SendRequest {

  send(String email) {
    Map<String, String> bodyJson = {"email": email};
    String body = json.encode(bodyJson);
    post(body);
  }

  @override
  getRoute() {
    return "sendEmailCode";
  }
}
