import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';
import 'package:test/test.dart';

void main() {
  group('Auth token tests', () {

    test('.getPermissionFromString() granted', () {
      expect(ConnectionPermission.getPermissionFromString("Granted"), ConnectionPermission.granted);
    });

    test('.getPermissionFromString() requested', () {
      expect(ConnectionPermission.getPermissionFromString("requested"), ConnectionPermission.requested);
    });

    test('.getPermissionFromString() denied', () {
      expect(ConnectionPermission.getPermissionFromString("denied"), ConnectionPermission.denied);
    });

    test('.getPermissionFromString() non', () {
      expect(ConnectionPermission.getPermissionFromString("invalid"), null);
    });
  });
}
