import 'package:graduation_gathering/Profile/Connections/connection.dart';
import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:graduation_gathering/Profile/Connections/connection_profile.dart';
import 'package:graduation_gathering/Profile/Connections/connection_type.dart';
import 'package:test/test.dart';

void main() {
  group('Connection Tests', () {

    Connection connection = Connection(ConnectionProfile("id", "email", "student", "name", "faculty", "school", "course"), null, ConnectionPermission.granted);
    Connection connectionNoName = Connection(ConnectionProfile("id", "email", "student", null, "faculty", "school", "course"), null, ConnectionPermission.granted);

    test('.getConnectionProfile()', () {
      expect(connection.getConnectionProfile(), ConnectionProfile("id", "email", "student", "name", "faculty", "school", "course"));
    });

    test('.getAccountTypeString()', () {
      expect(connection.getAccountTypeString(), "Student");
    });

    test('.getPermissionTo()', () {
      expect(connection.getPermissionTo(), null);
    });

    test('.getPermissionFrom()', () {
      expect(connection.getPermissionFrom(), ConnectionPermission.granted);
    });

    test('.getConnectionType()', () {
      expect(connection.getConnectionType(), ConnectionType.to);
    });

    test('.toString()', () {
      expect(connection.toString(), {"email", ConnectionPermission.granted, null}.toString());
    });

    test('.getMainText() has name', () {
      expect(connection.getMainText(), "name");
    });

    test('.getMainText() has no name', () {
      expect(connectionNoName.getMainText(), "email");
    });

    test('.getSubText() has name', () {
      expect(connection.getSubText(), "email");
    });

    test('.getSubText() has no name', () {
      expect(connectionNoName.getSubText(), '');
    });
  });
}
