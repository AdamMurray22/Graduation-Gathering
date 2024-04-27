import 'package:graduation_gathering/Auth/auth_token.dart';
import 'package:test/test.dart';

void main() {
  group('Auth token tests', () {

    final AuthToken token1 = AuthToken("token");
    final AuthToken token2 = AuthToken("token");
    final AuthToken token3 = AuthToken("different token");

    test('.getToken', () {
      expect(token1.getToken(), "token");
    });

    test('== same value', () {
      expect(token1 == token2, true);
    });

    test('== different value', () {
      expect(token1 == token3, false);
    });

    test('== same object', () {
      expect(token1 == token1, true);
    });
  });
}
