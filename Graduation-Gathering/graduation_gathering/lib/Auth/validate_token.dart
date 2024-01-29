import 'package:graduation_gathering/Auth/auth_token.dart';
import '../AWS/send_request.dart';

class ValidateToken extends SendRequest
{

  ValidateToken()
  {
    setServerURL();
  }

  Future<bool> valid(AuthToken? token) async {
    if (token == null)
    {
      return false;
    }
    return await _send(token);
  }

  Future<bool> _send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    return responseBody == "true";
  }

  @override
  setServerURL() {
    serverURL = "https://xgetisy5fg.execute-api.eu-west-2.amazonaws.com/prod/TokenValid";
  }
}