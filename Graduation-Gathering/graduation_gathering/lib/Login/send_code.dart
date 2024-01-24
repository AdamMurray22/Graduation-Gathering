import 'dart:convert';
import '../AWS/send_request.dart';

class SendCode extends SendRequest {

  SendCode()
  {
    setServerURL();
  }

  Future<bool> send(String email, String code) async {
    Map<String, String> bodyJson = {"email": email ,"code": code};
    String body = json.encode(bodyJson);
    return (await post(body)).toLowerCase() == "true";
  }

  @override
  setServerURL() {
    serverURL = "https://95qywkwmoh.execute-api.eu-west-2.amazonaws.com/prod/validateCode";
  }
}
