import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';

import 'connection_profile.dart';
import 'connection_type.dart';

class Connection
{
  final ConnectionProfile _connectionProfile;
  final ConnectionPermission? _permissionTo;
  final ConnectionPermission? _permissionFrom;
  late final ConnectionType _connectionType;

  Connection(this._connectionProfile, this._permissionTo, this._permissionFrom)
  {
    if (_permissionTo == null)
    {
      _connectionType = ConnectionType.to;
    }
    else if (_permissionFrom == null)
    {
      _connectionType = ConnectionType.from;
    }
    else
    {
      _connectionType = ConnectionType.both;
    }
  }

  ConnectionProfile getConnectionProfile()
  {
    return _connectionProfile;
  }

  String getMainText()
  {
    return _connectionProfile.getMainText();
  }

  String getSubText()
  {
    return _connectionProfile.getSubText();
  }

  String getAccountTypeString()
  {
    return _connectionProfile.getAccountType().accountTypeAsString;
  }

  ConnectionPermission? getPermissionTo()
  {
    return _permissionTo;
  }

  ConnectionPermission? getPermissionFrom()
  {
    return _permissionFrom;
  }

  ConnectionType getConnectionType()
  {
    return _connectionType;
  }

  @override
  String toString() {
    return {_connectionProfile.getEmail(), _permissionFrom, _permissionTo}.toString();
  }
}