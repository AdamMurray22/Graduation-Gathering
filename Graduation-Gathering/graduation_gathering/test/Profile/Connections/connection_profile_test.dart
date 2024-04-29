import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/account_type.dart';
import 'package:test/test.dart';

void main() {
  group('Connection Profile Tests', () {

    ConnectionProfile profile = ConnectionProfile("id", "email", "student", "name", "faculty", "school", "course");
    ConnectionProfile profile2 = ConnectionProfile("id", "email", "student", null, "faculty", "school", "course");

    test('.getAccountTypeString()', () {
      expect(profile.getAccountTypeString(), "Student");
    });

    test('.getAccountType()', () {
      expect(profile.getAccountType(), AccountType.student);
    });

    test('.getName()', () {
      expect(profile.getName(), "name");
    });

    test('.getFaculty()', () {
      expect(profile.getFaculty(), "faculty");
    });

    test('.getSchool()', () {
      expect(profile.getSchool(), "school");
    });

    test('.getCourse()', () {
      expect(profile.getCourse(), "course");
    });

    test('.getMainText() has name', () {
      expect(profile.getMainText(), "name");
    });

    test('.getMainText() has no name', () {
      expect(profile2.getMainText(), "email");
    });

    test('.getSubText() has name', () {
      expect(profile.getSubText(), "email");
    });

    test('.getSubText() has no name', () {
      expect(profile2.getSubText(), '');
    });
  });
}
