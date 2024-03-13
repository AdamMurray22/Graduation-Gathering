import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';

import 'connection_profile.dart';

class Connection
{
  final ConnectionProfile _connectionProfile;
  ConnectionPermission _permission;

  Connection(this._connectionProfile, this._permission);

  String getToUserId()
  {
    return _connectionProfile.getId();
  }

  String getMainText()
  {
    if (_connectionProfile.getName() != null)
    {
      return _connectionProfile.getName()!;
    }
    return _connectionProfile.getEmail();
  }
}