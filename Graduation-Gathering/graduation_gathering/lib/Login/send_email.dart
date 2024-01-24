import 'dart:convert';
import '../AWS/send_request.dart';

class SendEmail extends SendRequest {

  SendEmail()
  {
    setServerURL();
  }

  send(String email) {
    Map<String, String> bodyJson = {"email": email};
    String body = json.encode(bodyJson);
    post(body);
  }

  @override
  setServerURL() {
    serverURL = "https://ejkqyhlvya.execute-api.eu-west-2.amazonaws.com/prod/sendEmailCodes";
  }
}
