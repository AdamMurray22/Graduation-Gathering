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

  /// Sets the == operator to check if the tokens are the same.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthToken &&
              runtimeType == other.runtimeType &&
              getToken() == other.getToken();

  /// Sets the hashcode to use the underlying token.
  @override
  int get hashCode => _token.hashCode;
}