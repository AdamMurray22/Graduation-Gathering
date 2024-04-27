import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/account_type.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:test/test.dart';

void main() {
  group('Profile Settings Tests', () {

    ProfileSettings profile = ProfileSettings(0, "id", "email", "student", "name", "faculty", "school", "course", GradZones([]));
    ProfileSettings profile2 = ProfileSettings(0, "id", "email", "student", "name", "faculty", "school", "course", GradZones([]));

    test('.toJson()', () {
      expect(profile.toJson(), {'id': "id", 'hasLoggedInBefore': false, 'email': "email",
        'accountType': "Student", 'name': "name", 'faculty': "faculty",
        'school': "school", 'course': "course", 'userGradZoneIds': <dynamic>{}});
    });

    test('.getId()', () {
      expect(profile.getId(), "id");
    });

    test('.getEmail()', () {
      expect(profile.getEmail(), "email");
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

    test('.getHasLoggedInBefore()', () {
      expect(profile.getHasLoggedInBefore(), false);
    });

    test('.getUserGradZones()', () {
      expect(profile.getUserGradZones(), GradZones([]));
    });

    test('.setName()', () {
      expect(profile2.getName(), "name");
      profile2.setName("new name");
      expect(profile2.getName(), "new name");
    });

    test('.setFaculty()', () {
      expect(profile2.getFaculty(), "faculty");
      profile2.setFaculty("new faculty");
      expect(profile2.getFaculty(), "new faculty");
    });
    test('.setSchool()', () {
      expect(profile2.getSchool(), "school");
      profile2.setSchool("new school");
      expect(profile2.getSchool(), "new school");
    });
    test('.setCourse()', () {
      expect(profile2.getCourse(), "course");
      profile2.setCourse("new course");
      expect(profile2.getCourse(), "new course");
    });

    test('.setHasLoggedInBefore()', () {
      expect(profile2.getHasLoggedInBefore(), false);
      profile2.setHasLoggedInBefore(true);
      expect(profile2.getHasLoggedInBefore(), true);
    });
  });
}
