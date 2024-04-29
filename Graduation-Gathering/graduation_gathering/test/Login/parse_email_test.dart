import 'package:graduation_gathering/Login/parse_email.dart';
import 'package:test/test.dart';

void main() {
  group('Auth token tests', () {

    final ParseEmail parseEmail = ParseEmail();

    test('.validate valid student email', () {
      expect(parseEmail.validate("up2166905@myport.ac.uk"), true);
    });

    test('.validate valid staff email', () {
      expect(parseEmail.validate("up2166905@port.ac.uk"), true);
    });

    test('.validate not university email', () {
      expect(parseEmail.validate("up2166905@gmail.com"), false);
    });
  });
}
