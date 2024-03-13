import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';

class Connection
{
  String _toUserId;
  ConnectionPermission _permission;

  Connection(this._toUserId, this._permission);

  String getToUserId()
  {
    return _toUserId;
  }
}