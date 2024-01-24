import 'dart:convert';
import 'package:http/http.dart' as http;

class SendEmailCode {
  final String _serverURL =
      "https://ejkqyhlvya.execute-api.eu-west-2.amazonaws.com/prod/sendEmailCodes";

  send(String email) {
    Map<String, String> bodyJson = {"email": email};
    String body = json.encode(bodyJson);
    _post(body);
  }

  Future<String> _post(String body) async {
    Uri uri = _getUri();
    http.Response response = await http.post(uri, body: body);
    return response.body;
  }

  Uri _getUri() {
    Uri uri = Uri.parse(_serverURL);
    return uri;
  }
}
