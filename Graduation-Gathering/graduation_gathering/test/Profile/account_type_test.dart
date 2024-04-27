import 'package:graduation_gathering/Profile/account_type.dart';
import 'package:test/test.dart';

void main() {
  group('Account Type Tests', () {
    test('.getAccountTypeFromString() valid uni building', () {
      expect(AccountType.getAccountTypeFromString("Student"), AccountType.student);
    });

    test('.getAccountTypeFromString() valid Staff', () {
      expect(AccountType.getAccountTypeFromString("staff"), AccountType.staff);
    });

    test('.getAccountTypeFromString() invalid id', () {
      expect(AccountType.getAccountTypeFromString("invalid"), null);
    });
  });
}
