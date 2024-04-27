import 'package:graduation_gathering/Map/Zones/grad_zones.dart';
import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/Connections/other_user_profiles.dart';
import 'package:graduation_gathering/Profile/profile_settings.dart';
import 'package:test/test.dart';

void main() {
  group('Connections Tests', () {

    Connections connections = Connections([{"fromUser": "User1", "toUser": "id", "permission": "Granted"}],
        OtherUserProfiles([{"userID": "User1",
          "userEmail": "email1", "accountType": "student", "userName": "name1",
          "faculty": null, "school": null, "course": null}]),
        ProfileSettings(0, "id", "email", "student", "name", "faculty", "school", "course", GradZones([])));

    test('.getConnections()', () {
      expect(connections.getConnections(), {Connection(ConnectionProfile("User1", "email1", "student", "name1", null, null, null), null, ConnectionPermission.granted)});
    });
  });
}
