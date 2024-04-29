import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';

/// Securely stores and retrieves authorisation tokens.
class TokenStorage
{
  // The secure storage used.
  final _storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  /// Retrieves a token that has been stored on the device.
  Future<AuthToken?> getToken() async {
    String? value = await _storage.read(key: "auth token");
    if (value == null)
    {
      return null;
    }
    return AuthToken(value);
  }

  /// Securely stores the given token in storage on the device.
  writeToken(AuthToken authToken) async {
    await _storage.write(key: "auth token", value: authToken.getToken());
  }

  clearToken() async
  {
    await storage.write(key: "auth token", value: null);
  }
}