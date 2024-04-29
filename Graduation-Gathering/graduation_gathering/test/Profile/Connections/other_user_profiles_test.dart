import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:test/test.dart';

void main() {
  group('Other User Profiles tests', () {

    OtherUserProfiles profiles = OtherUserProfiles([{"userID": "User1",
      "userEmail": "email", "accountType": "student", "userName": "name",
      "faculty": "faculty", "school": "school", "course": "course"}]);

    test('.getUserFromId() valid ID', () {
      expect(profiles.getUserFromId("User1"), ConnectionProfile("User1", "email", "student", "name", "faculty", "school", "course"));
    });

    test('.getUserFromId() invalid ID', () {
      expect(profiles.getUserFromId("NotUser1"), null);
    });
  });
}
