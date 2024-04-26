/// An Authentication token.
class AuthToken
{
  /// Token in String form.
  final String _token;

  AuthToken(this._token);

  /// Retrieves the token in String form.
  String getToken()
  {
    return _token;
  }
}