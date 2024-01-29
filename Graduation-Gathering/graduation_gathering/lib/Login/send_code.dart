import 'dart:convert';
import 'package:tuple/tuple.dart';

import '../AWS/send_request.dart';

class SendCode extends SendRequest {

  SendCode()
  {
    setServerURL();
  }

  Future<Tuple2<bool, String?>> send(String email, String code) async {
    Map<String, String> bodyJson = {"email": email ,"code": code};
    String body = json.encode(bodyJson);
    String responseBody = await post(body);
    Map<String, dynamic> responseJson = json.decode(responseBody);
    return Tuple2<bool, String?>(responseJson["validated"], responseJson["token"]);
  }

  @override
  setServerURL() {
    serverURL = "https://95qywkwmoh.execute-api.eu-west-2.amazonaws.com/prod/validateCode";
  }
}
