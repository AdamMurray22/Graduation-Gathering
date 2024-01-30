import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_gathering/Auth/auth_token.dart';

class TokenStorage
{
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<AuthToken?> getToken() async {
    String? value = await storage.read(key: "auth token");
    if (value == null)
    {
      return null;
    }
    return AuthToken(value);
  }

  writeToken(AuthToken authToken) async {
    await storage.write(key: "auth token", value: authToken.getToken());
  }
}