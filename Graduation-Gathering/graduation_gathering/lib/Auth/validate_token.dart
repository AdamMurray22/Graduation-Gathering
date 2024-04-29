import 'package:graduation_gathering/Auth/auth_token.dart';
import '../AWS/send_request.dart';

/// Sends a request to the server to validate a token.
class ValidateToken extends SendRequest
{

  /// Sends the request and returns whether the given token is valid or not.
  Future<bool> valid(AuthToken? token) async {
    if (token == null)
    {
      return false;
    }
    return await _send(token);
  }

  // Sends the request.
  Future<bool> _send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    return responseBody == "true";
  }

  /// Returns the route within the server to the tokenValid endpoint.
  @override
  getRoute() {
    return "tokenValid";
  }
}