import 'package:graduation_gathering/Profile/Connections/connection_permission_enum.dart';

import 'connection_profile.dart';
import 'connection_type.dart';

/// Stores a connection that a user has to another user, both from this user to
/// the other user and from the other user to this user.
class Connection
{
  // User profile of the other User.
  final ConnectionProfile _connectionProfile;
  // The permission that this user has to see the other user.
  final ConnectionPermission? _permissionTo;
  // The permission that the other user has to see this user.
  final ConnectionPermission? _permissionFrom;
  // States whether the user has a type of permission with the other user,
  // the other way around, or both.
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

  /// Returns the Profile of the other user.
  ConnectionProfile getConnectionProfile()
  {
    return _connectionProfile;
  }

  /// Returns the main text to display for the other User.
  String getMainText()
  {
    return _connectionProfile.getMainText();
  }

  /// Returns the sub text to display for the other User.
  String getSubText()
  {
    return _connectionProfile.getSubText();
  }

  /// Returns the account type to display for the other User.
  String getAccountTypeString()
  {
    return _connectionProfile.getAccountType().accountTypeAsString;
  }

  /// Returns the permission that this user has to see the other user.
  ConnectionPermission? getPermissionTo()
  {
    return _permissionTo;
  }

  /// Returns the permission that the other user has to see this user.
  ConnectionPermission? getPermissionFrom()
  {
    return _permissionFrom;
  }

  /// Returns the connection type.
  ConnectionType getConnectionType()
  {
    return _connectionType;
  }

  /// Returns this object as a string as the combination of the other users email,
  /// then the permission from, then the permission to.
  @override
  String toString() {
    return {_connectionProfile.getEmail(), _permissionFrom, _permissionTo}.toString();
  }
}